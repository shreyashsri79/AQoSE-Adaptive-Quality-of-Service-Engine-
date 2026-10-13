.PHONY: check env venv build test-go test-py testbed-check fuzz

check: test-go test-py

build:
	go build -o bin/ ./cmd/...

test-go:
	gofmt -l . | (! grep .)
	go vet ./...
	go test ./...

test-py:
	.venv/bin/pytest -q

# Builds the real testbed and runs traffic through it. Replaces any running
# testbed and takes a few minutes, so it is not part of `check`.
testbed-check: build
	AQOS_INTEGRATION=1 go test -count=1 -run TestTestbed -v ./internal/testbed/
	AQOS_INTEGRATION=1 .venv/bin/pytest -q -s ml/tests/test_gen_testbed.py ml/tests/test_run_testbed.py \
		ml/tests/test_extract_testbed.py ml/tests/test_enforce_testbed.py \
		ml/tests/test_controller_testbed.py

# Throws generated proposals at the safety shield. Run before a matrix run;
# FUZZTIME is per target.
FUZZTIME ?= 150s
fuzz:
	go test -run '^$$' -fuzz '^FuzzCheck$$' -fuzztime $(FUZZTIME) ./internal/shield/
	go test -run '^$$' -fuzz '^FuzzCheckJSON$$' -fuzztime $(FUZZTIME) ./internal/shield/

env:
	scripts/check-env.sh

venv:
	python3 -m venv .venv
	.venv/bin/pip install -q --upgrade pip
	.venv/bin/pip install -q -r requirements.lock
