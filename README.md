# Adaptive QoS Engine

An intent-aware QoS controller on top of Linux CAKE. Entry for Tata Elxsi Teliport Season 4.

- [Project log](<Project Log.md>): what was done, why, what was measured, what is next
- [Product requirements](<Adaptive QoS Engine Product Requirements (Teliport S4).md>)
- [Build plan](<Build Plan and Timeline.md>)
- [Technical specification](<Technical Specification.md>)
- [Interface contracts](contracts/README.md)
- [Pinned versions](VERSIONS.md)

## Setup

```
make venv    # create .venv from requirements.lock
make env     # compare this machine against VERSIONS.md
make check   # Go vet and tests, Python tests (about a minute)
make build   # binaries into bin/
```

## Testbed

No `sudo` is needed.

```
bin/aqos-testbed up contracts/examples/scenario.S1.yaml
bin/aqos-testbed exec host-laptop -- ping -c 3 10.78.0.10
bin/aqos-testbed check-rate
bin/aqos-testbed event link_rate direction=down rate_kbit=20000
bin/aqos-testbed down

make testbed-check   # builds the testbed and runs traffic, runs, the extractor and the controller through it
```

## Running an experiment

```
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run one --scenario S1 --config B2 --seed 7
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run one --scenario S6 --config O2 --seed 7   # with the controller
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run matrix configs/matrix-3a.yaml   # resumes where it stopped
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run show results/S1-B2-s0007
```

Configurations: `B0` no QoS, `B2` plain CAKE, `B4` threshold rules, `O1` the model deciding by top label, `O2` the model deciding by expected damage. The last three start the ML service and the controller (`aqosd`) in the router; `O1` and `O2` need a trained model.

Results land in `results/<run_id>/`. A controller run also writes `actions.jsonl` (every proposal, the shield's verdict and what became of it) and `controller.json` (counts). To watch a run live: `bin/aqos-exporter` and `docker compose -f dashboards/compose.yaml up -d`.

## Driving the router by hand

Inside a testbed with CAKE set up (`bin/aqos-testbed exec router -- configs/baselines/B2.sh 100000 20000`):

```
bin/aqos-testbed exec router -- bin/aqos-ctl marking install
bin/aqos-testbed exec router -- bin/aqos-ctl flows
bin/aqos-testbed exec router -- bin/aqos-ctl label udp 10.77.0.10:41000 10.78.0.10:7000 voice
bin/aqos-testbed exec router -- bin/aqos-ctl rate down 50000
bin/aqos-testbed exec router -- bin/aqos-ctl tins
```

## Dataset

```
PYTHONPATH=ml .venv/bin/python -m aqos_ml.dataset scenarios                       # 48 training scenarios
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run matrix scenarios/train/matrix.yaml --results results-train
PYTHONPATH=ml .venv/bin/python -m aqos_ml.dataset build                           # data/dataset/v1.jsonl.gz
```

Public datasets come in as flow tables made on Kaggle (`kaggle/`), under `data/public/`.

## Model, damage table, comparison

```
PYTHONPATH=ml .venv/bin/python -m aqos_ml.train --dataset data/dataset/v1.jsonl.gz     # random forest and LightGBM, into models/
PYTHONPATH=ml .venv/bin/python -m aqos_ml.compare --dataset data/dataset/v1.jsonl.gz   # models against rules: reports/head-to-head-*.md
PYTHONPATH=ml .venv/bin/python -m aqos_ml.damage run --seeds 1-3                       # measure the damage table (hours; resumable)
PYTHONPATH=ml .venv/bin/python -m aqos_ml.damage score                                 # configs/damage_table.measured.yaml
make fuzz                                                                              # the safety shield's fuzz tests
```

## Feature records from a capture

```
bin/aqos-extract -pcap capture.pcap -out features.jsonl -keys keys.jsonl
```

## Layout

| Path | Contents |
| --- | --- |
| `contracts/` | Schemas, examples and Go types shared by Systems and ML |
| `cmd/aqos-testbed`, `internal/testbed` | The emulated home network (chunk 2A) |
| `internal/extract`, `internal/netfilter`, `internal/capture`, `cmd/aqos-extract` | Feature extractor, offline and live (chunk 3B) |
| `internal/cake`, `internal/exporter`, `configs/baselines/`, `dashboards/` | Baselines and metrics (chunk 3A) |
| `ml/aqos_ml/run` | Experiment runner (chunk 3C) |
| `ml/aqos_ml/dataset` | Dataset builder (chunk 4A) |
| `ml/aqos_ml/rules.py`, `ml/aqos_ml/evaluate.py` | Threshold rules and the shared scoring code (chunk 4B) |
| `internal/enforce`, `cmd/aqos-ctl` | Enforcer (chunk 4C) |
| `cmd/aqos-watchdog`, `internal/heartbeat` | Watchdog (chunk 4D) |
| `ml/aqos_ml/features.py`, `train.py`, `model.py`, `serve.py` | Classifier and the ML service (chunk 5A) |
| `ml/aqos_ml/damage.py`, `configs/damage_*.yaml` | Damage table, measured (chunk 5B) |
| `ml/aqos_ml/decide.py` | Decision engine (chunk 5C) |
| `internal/shield`, `configs/shield.yaml` | Safety shield (chunk 5D) |
| `dashboards/build.py` | Dashboard generator (chunk 5E) |
| `cmd/aqosd`, `internal/controller` | The controller (chunk 6A) |
| `ml/aqos_ml/compare.py` | Models against rules, the go/no-go report (chunk 6B) |
| `scenarios/` | Scenario files |
| `kaggle/` | Reducing public datasets to flow tables |
| `ml/aqos_ml/gen` | Traffic generators (chunk 2B) |
| `ml/aqos_ml/capture.py` | Recording and reviewing real-app captures (chunk 2C) |
| `ml/tests/` | Python tests |
| `scripts/` | Environment check, data fetching, the Purdue reader |
