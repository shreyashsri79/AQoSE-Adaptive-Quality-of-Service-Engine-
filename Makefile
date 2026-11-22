.PHONY: check env venv build test-go test-py testbed-check fuzz
.DEFAULT_GOAL := check

# Go is the default runtime. Rust builds and comparisons remain opt-in.
PREFIX ?= /usr/local
DESTDIR ?=
CARGO ?= $(HOME)/.cargo/bin/cargo
RUST_MANIFEST = rust/aqos-classify/Cargo.toml
.PHONY: build-rust test-rust bench-rust

build-rust:
	$(CARGO) build --locked --release --manifest-path $(RUST_MANIFEST)
	mkdir -p bin
	cp rust/aqos-classify/target/release/aqos-classify-rs bin/
	cp rust/aqos-classify/target/release/aqos-core-bench-rs bin/

test-rust: build build-rust
	$(CARGO) fmt --manifest-path $(RUST_MANIFEST) -- --check
	$(CARGO) clippy --locked --manifest-path $(RUST_MANIFEST) --all-targets -- -D warnings
	$(CARGO) test --locked --manifest-path $(RUST_MANIFEST)
	AQOS_RUST_TEST=1 .venv/bin/pytest -q ml/tests/test_rust_backend.py

bench-rust: build build-rust
	.venv/bin/python scripts/bench-rust.py --out reports/rust-migration.json

RUNTIME_MANIFEST = rust/aqos-runtime/Cargo.toml
WATCHDOG_MANIFEST = rust/aqos-watchdog/Cargo.toml
.PHONY: build-runtime test-runtime runtime-testbed-check bench-runtime
build-runtime:
	$(CARGO) build --locked --release --manifest-path $(RUNTIME_MANIFEST)
	$(CARGO) build --locked --release --manifest-path $(WATCHDOG_MANIFEST)
	mkdir -p bin
	cp rust/aqos-runtime/target/release/aqos-extract-rs rust/aqos-runtime/target/release/aqos-ctl-rs rust/aqos-runtime/target/release/aqosd-rs rust/aqos-runtime/target/release/aqos-cake-reader-rs rust/aqos-runtime/target/release/aqos-reflector-rs rust/aqos-runtime/target/release/aqos-exporter-rs bin/
	cp rust/aqos-watchdog/target/release/aqos-watchdog-rs bin/

bench-runtime: build build-runtime
	.venv/bin/python scripts/bench-runtime.py

test-runtime: build build-runtime
	$(CARGO) fmt --manifest-path $(RUNTIME_MANIFEST) -- --check
	$(CARGO) fmt --manifest-path $(WATCHDOG_MANIFEST) -- --check
	$(CARGO) clippy --locked --manifest-path $(RUNTIME_MANIFEST) --all-targets -- -D warnings
	$(CARGO) clippy --locked --manifest-path $(WATCHDOG_MANIFEST) --all-targets -- -D warnings
	$(CARGO) test --locked --manifest-path $(RUNTIME_MANIFEST)
	$(CARGO) test --locked --manifest-path $(WATCHDOG_MANIFEST)
	$(CARGO) build --locked --manifest-path $(RUNTIME_MANIFEST)
	AQOS_EXTRACT_BIN=rust/aqos-runtime/target/debug/aqos-extract-rs AQOS_RUNTIME_TEST=1 .venv/bin/pytest -q ml/tests/test_extract.py ml/tests/test_rust_runtime.py

runtime-testbed-check: build build-rust build-runtime
	$(CARGO) build --locked --manifest-path $(RUNTIME_MANIFEST)
	AQOS_RUNTIME_INTEGRATION=1 .venv/bin/pytest -q ml/tests/test_rust_runtime_testbed.py
	AQOS_INTEGRATION=1 AQOS_RUNTIME=rust AQOS_SERVICE=rust .venv/bin/pytest -q ml/tests/test_controller_testbed.py

check: test-go test-py

.PHONY: build-testbed build-go build-go-reference install-runtime
build: build-go
	@set -e; for name in aqos-testbed aqos-classify aqos-core-bench aqos-extract aqos-ctl aqosd aqos-cake-reader aqos-reflector aqos-exporter aqos-watchdog; do ln -sfn "go/$$name" "bin/$$name"; done

# Development harness only; the installed runtime does not include the testbed.
build-testbed:
	mkdir -p bin
	go build -o bin/aqos-testbed ./cmd/aqos-testbed

# Separate output preserves the optional Rust binaries.
build-go:
	mkdir -p bin/go
	go build -o bin/go/ ./cmd/...

# Compatibility target used by the retained comparison scripts.
build-go-reference: build-go

# Stage Go runtime commands without the development testbed.
install-runtime: build-go
	install -d "$(DESTDIR)$(PREFIX)/bin"
	@set -e; for name in aqos-classify aqos-extract aqos-ctl aqosd aqos-cake-reader aqos-reflector aqos-exporter aqos-watchdog; do install -m 755 "bin/go/$$name" "$(DESTDIR)$(PREFIX)/bin/$$name"; done

test-go:
	# Saved research sources under reports/ are evidence, not live packages.
	gofmt -l cmd internal contracts | (! grep .)
	go vet ./cmd/... ./internal/... ./contracts/...
	go test ./cmd/... ./internal/... ./contracts/...

test-py: build
	.venv/bin/pytest -q

# Builds the real testbed and runs traffic through it. Replaces any running
# testbed and takes a few minutes, so it is not part of `check`.
testbed-check: build
	AQOS_INTEGRATION=1 go test -count=1 -run TestTestbed -v ./internal/testbed/
	AQOS_INTEGRATION=1 .venv/bin/pytest -q -s ml/tests/test_gen_testbed.py ml/tests/test_run_testbed.py \
		ml/tests/test_extract_testbed.py ml/tests/test_enforce_testbed.py \
		ml/tests/test_controller_testbed.py

# Go shield fuzzing by default; retain the optional Rust generative stress target.
FUZZTIME ?= 150s
fuzz: fuzz-go-reference

.PHONY: fuzz-runtime
fuzz-runtime:
	AQOS_FUZZ_SECONDS=$(patsubst %s,%,$(FUZZTIME)) $(CARGO) test --locked --release --manifest-path $(RUNTIME_MANIFEST) --test generative -- --ignored --nocapture

.PHONY: fuzz-go-reference
fuzz-go-reference:
	go test -run '^$$' -fuzz '^FuzzCheck$$' -fuzztime $(FUZZTIME) ./internal/shield/
	go test -run '^$$' -fuzz '^FuzzCheckJSON$$' -fuzztime $(FUZZTIME) ./internal/shield/

# Continuous host testbed run; reserve disk space and record process resources.
# Use a fresh output directory. Does not schedule a reminder or run on a router.
SOAK_SECONDS ?= 21600
SOAK_RESULTS ?= results-rust-soak
.PHONY: soak-runtime
soak-runtime: build build-rust build-runtime
	.venv/bin/python scripts/soak-runtime.py --seconds $(SOAK_SECONDS) --results "$(SOAK_RESULTS)"

env:
	scripts/check-env.sh

venv:
	python3 -m venv .venv
	.venv/bin/pip install -q --upgrade pip
	.venv/bin/pip install -q -r requirements.lock
