<p align="center">
  <img src="docs/images/aqose-flow-hero.png" alt="Mixed traffic goes into AQoSE, each connection gets its own CAKE lane, calls stay smooth" width="100%">
</p>

<h1 align="center">AQoSE · Adaptive QoS Engine</h1>

<p align="center">
  <b>Your router can't tell a video call from a download. AQoSE can.</b><br>
  A small, safety-guarded classifier that tells Linux CAKE which connection is the call or the game,<br>
  from the sizes and timing of its first eight packets: headers only, never content.
</p>

<p align="center">
  <a href="reports/paper/aqose-report.pdf"><img alt="Full report" src="https://img.shields.io/badge/report-PDF-1C3F86?style=for-the-badge"></a>
  <a href="https://youtu.be/k6ccbBaxwUg"><img alt="Explainer video" src="https://img.shields.io/badge/video-YouTube-C8452B?style=for-the-badge"></a>
  <img alt="Go 1.26" src="https://img.shields.io/badge/Go-1.26-00ADD8?style=for-the-badge&logo=go&logoColor=white">
  <img alt="Python 3.14" src="https://img.shields.io/badge/Python-3.14-3776AB?style=for-the-badge&logo=python&logoColor=white">
  <img alt="LightGBM" src="https://img.shields.io/badge/LightGBM-4.7-6A4FD0?style=for-the-badge">
  <img alt="Linux CAKE" src="https://img.shields.io/badge/Linux-CAKE-1D8A5A?style=for-the-badge&logo=linux&logoColor=white">
</p>

<p align="center">
  Tata Elxsi <b>Teliport Season 4</b>, Case Study 3 · Team <b>BugHeBug</b>: Shreyash Neeraj, Mridul Jaiswal, Sachi Jha (VIT Bhopal University)
</p>

---

AQoSE is a research prototype tested in a Linux network-namespace testbed.
It has not yet been validated on physical routers or in homes.

## <img src="docs/images/kid-problem.png" width="44" align="top"> The problem

CAKE, the best open-source queue manager on home routers, is fair: first between devices, then between each device's connections. That keeps most calls smooth. It breaks in one everyday situation: **a call or a game on a device that is also downloading, uploading or sharing files.** The call becomes one connection among many, gets a sliver of its own device's share, and nothing tells CAKE it is the call.

- CAKE *can* prioritise, through four priority lanes (tins), but only when packets carry a priority mark. Apps rarely set one, and ISPs often strip it.
- Tools that sort traffic on home routers often use fixed thresholds. Calls and cloud games can resemble bulk traffic under these rules.

## <img src="docs/images/kid-solution.png" width="44" align="top"> What AQoSE does

1. **Listens** to the first 8 packet headers of every new connection. One nftables rule hands them to the controller; no payload, no decryption.
2. **Predicts** what the connection is, with odds for 7 classes: voice call, game / cloud game, video call, streaming, web, large download, backup / P2P.
3. **Decides** the CAKE tin with the lowest *expected damage*, inside hard safety guards.
4. **Writes one label, once,** into the kernel's connection tracker. CAKE applies it to every packet in both directions; AQoSE never touches the packet path.
5. **Watches** every second with a cheap, model-free check, re-asks the classifier only when a flow changes, and rolls back any change that adds delay.

Remove two rules and the system is off. A mark of zero means plain CAKE, by construction.

## <img src="docs/images/kid-model.png" width="44" align="top"> How it decides

<p align="center"><img src="docs/images/how-the-model-works-minimal.png" alt="28 flow features go into 259 decision trees, which output calibrated probabilities for 7 classes" width="85%"></p>

**The classifier** is LightGBM: 37 boosting rounds for each of 7 classes, 259 trees, calibrated with temperature scaling. It reads 28 numbers: 8 packet sizes signed by direction, the 7 gaps between them, IP version, protocol, the port *class* of each end (never raw port numbers) and 9 window statistics. The trees are exported as data and run in Go. Training data is split by capture session, never by record.

<table>
<tr>
<td width="50%" valign="top">

**The decision engine** doesn't just take the top label. A wrong lane doesn't always hurt the same: a call in Bulk is a disaster, a download in Voice mostly harmless. We measured the harm of assigning each traffic class to each lane in the testbed. That is the *damage table*. For each tin, AQoSE weighs the odds by the damage and picks the lowest:

$$E[t] = \sum_{c} P(c)\, D[c][t]$$

Hard guards sit on top: Voice only if call + game > 50%; Bulk only if > 80% sure, never on first packets alone and never for UDP; ties never go to Bulk.

</td>
<td width="50%"><img src="docs/images/expected-damage-full.png" alt="Probability input, damage matrix, expected-cost calculator and tin selector around the expected-damage engine"></td>
</tr>
</table>

<p align="center"><img src="docs/images/cake-queue.png" alt="CAKE's four tins: Voice, Video, Best Effort and Bulk, with their shares" width="70%"></p>

CAKE does the queuing. AQoSE only picks the tin: Voice has priority up to 25% of the line, Video up to 50%, Best Effort up to 100%, and Bulk always keeps at least a sixteenth so nothing is starved.

## <img src="docs/images/kid-safety.png" width="44" align="top"> Built to fail safe

Every change, from any part of the system, passes the same checks:

- **Safety shield**: a pure function. It rejects invalid or stale proposals, limits repeated lane changes, and clamps rate changes to safe steps.
- **Transactions**: snapshot, apply, read back, compare. A mismatch triggers restoration of the snapshot.
- **QoE verifier**: after a promotion, the change is undone if observed Voice/Video queue delay worsens beyond the configured thresholds.
- **Watchdog**: a separate process. If the controller's heartbeat goes quiet, it removes marking rules and restores plain CAKE.
- **Every decision is logged** with a plain-English reason explaining the traffic classification and selected tin.

## <img src="docs/images/kid-testing.png" width="44" align="top"> How it was tested

- A **rootless testbed** models devices, a router and an ISP bottleneck using Linux network namespaces.
- **Traffic generators** exercise calls, games, streaming, browsing and bulk transfers with per-packet timestamps.
- **Paired scenarios** compare router configurations using common seeds, with repeated baseline runs to estimate variation.
- **Frozen configurations** are checked with fresh seeds, replayed application traffic and IPv6.

## What we haven't shown

- **Emulation only.** No real router, no Wi-Fi, no real homes yet.
- **Generated calls don't adapt** their bitrate under pressure the way real apps do. The replayed WhatsApp calls are real traffic, but the app wasn't running.
- **The model is weaker on data sources it has never seen**, and some classes are thin in the test set.
- **Two known problems:** a cloud game above a quarter of the line outgrows the Voice tin, and the line estimator overreacts when its probes return after an outage.

**Next:** run on a real OpenWrt router, test live with real apps, then a field trial in volunteer homes. The [report](reports/paper/aqose-report.pdf) lists every limitation.

## <img src="docs/images/kid-architecture.png" width="44" align="top"> Quick start

Linux with CAKE, nftables and user namespaces; Go 1.26 for the runtime and
experiment testbed, and Python 3.14 for research tooling. Versions are pinned in [VERSIONS.md](VERSIONS.md).

```bash
make venv    # create .venv from requirements.lock
make env     # compare this machine against VERSIONS.md
make check   # Go formatting, vet and tests; Python and contract tests
make build   # Go runtime commands and testbed into bin/

scripts/demo.sh   # compare plain CAKE and AQoSE in the testbed
```

Go is the default for the router runtime and classifier. `make build` provides
`bin/aqosd`, `bin/aqos-classify`, `bin/aqos-extract`, `bin/aqos-ctl`,
`bin/aqos-cake-reader`, `bin/aqos-reflector`, `bin/aqos-watchdog`, and
`bin/aqos-exporter` as aliases to `bin/go/`. Python handles training, reporting
and traffic generation.

The runner defaults to `AQOS_RUNTIME=go` and `AQOS_SERVICE=go`; neither variable
is needed for normal runs. Missing binaries fail before the testbed is touched.
Dataset builds also use the Go extractor.

```bash
make testbed-check      # runs traffic through the real namespace testbed
make fuzz FUZZTIME=150s # Go shield fuzzing

PYTHONPATH=ml .venv/bin/python -m aqos_ml.run one \
  --scenario S6 --config O2 --seed 7 --results results-go-runtime

# The runner does not launch the dashboard exporter.
bin/aqos-exporter -file results-go-runtime/current/metrics.jsonl -listen :9108
```

The integration checks replace any running AQoSE testbed. Use a fresh results
directory when changing experiment inputs. B4 uses the Python rules service;
feature-noise experiments select
`AQOS_SERVICE=python AQOS_SERVE_ARGS="--feature-noise 1.0"` explicitly.

The Go intent API is unauthenticated and should remain on loopback.

To stage the Go runtime commands without the development testbed:

```bash
make install-runtime DESTDIR=/tmp/aqos-package PREFIX=/usr
```

The commands are installed under `/tmp/aqos-package/usr/bin/`. Router processes
need Linux networking facilities and `ip`, `tc`, and `nft`; they do not need the
Go compiler or Python. Supply the model, damage-table and shield-config paths
when launching the classifier and controller. This target builds for the host
architecture; OpenWrt cross-compilation and on-device validation remain separate work.

<p align="center">
  <a href="https://youtu.be/k6ccbBaxwUg">Watch the explainer video</a>
</p>

---

<details>
<summary><b>Reference: testbed, experiments, dataset, training and repository layout</b></summary>

### Documents

- [Full report](reports/paper/aqose-report.pdf) ([LaTeX source](reports/paper/aqose-report.tex))
- [Project log](<Project Log.md>): what was done, why, what was measured, what is next
- [Product requirements](<Adaptive QoS Engine Product Requirements (Teliport S4).md>)
- [Build plan](<Build Plan and Timeline.md>)
- [Technical specification](<Technical Specification.md>)
- [Interface contracts](contracts/README.md)
- [Pinned versions](VERSIONS.md)
- [Explainer video sources](reports/video/README.md)

### Testbed

No `sudo` is needed.

```
bin/aqos-testbed up contracts/examples/scenario.S1.yaml
bin/aqos-testbed exec host-laptop -- ping -c 3 10.78.0.10
bin/aqos-testbed check-rate
bin/aqos-testbed event link_rate direction=down rate_kbit=20000
bin/aqos-testbed down

make testbed-check   # builds the testbed and runs traffic, runs, the extractor and the controller through it
```

### Running an experiment

```
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run one --scenario S1 --config B2 --seed 7
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run one --scenario S6 --config O2 --seed 7   # with the controller
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run matrix configs/matrix-3a.yaml   # resumes where it stopped
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run show results/S1-B2-s0007
```

Configurations: `B0` no QoS, `B2` plain CAKE, `B4` threshold rules, `O1` the model deciding by top label, `O2` the model deciding by expected damage. The last three start the ML service and the controller (`aqosd`) in the router; `O1` and `O2` need a trained model.

Results land in `results/<run_id>/`. A controller run also writes `actions.jsonl` (every proposal, the shield's verdict and what became of it) and `controller.json` (counts). To watch a run live: `bin/aqos-exporter` and `docker compose -f dashboards/compose.yaml up -d`.

### Driving the router by hand

Inside a testbed with CAKE set up (`bin/aqos-testbed exec router -- configs/baselines/B2.sh 100000 20000`):

```
bin/aqos-testbed exec router -- bin/aqos-ctl marking install
bin/aqos-testbed exec router -- bin/aqos-ctl flows
bin/aqos-testbed exec router -- bin/aqos-ctl label udp 10.77.0.10:41000 10.78.0.10:7000 voice
bin/aqos-testbed exec router -- bin/aqos-ctl rate down 50000
bin/aqos-testbed exec router -- bin/aqos-ctl tins
```

### Dataset

```
PYTHONPATH=ml .venv/bin/python -m aqos_ml.dataset scenarios                       # 48 training scenarios
PYTHONPATH=ml .venv/bin/python -m aqos_ml.run matrix scenarios/train/matrix.yaml --results results-train
PYTHONPATH=ml .venv/bin/python -m aqos_ml.dataset build                           # data/dataset/v1.jsonl.gz
```

Public datasets come in as flow tables made on Kaggle (`kaggle/`), under `data/public/`.

### Model, damage table, comparison

```
PYTHONPATH=ml .venv/bin/python -m aqos_ml.train --dataset data/dataset/v1.jsonl.gz     # random forest and LightGBM, into models/
PYTHONPATH=ml .venv/bin/python -m aqos_ml.compare --dataset data/dataset/v1.jsonl.gz   # models against rules: reports/head-to-head-*.md
PYTHONPATH=ml .venv/bin/python -m aqos_ml.damage run --seeds 1-3                       # measure the damage table (hours; resumable)
PYTHONPATH=ml .venv/bin/python -m aqos_ml.damage score                                 # configs/damage_table.measured.yaml
make fuzz                                                                              # the safety shield's fuzz tests
```

### Feature records from a capture

```
bin/aqos-extract -pcap capture.pcap -out features.jsonl -keys keys.jsonl
```

### Layout

| Path | Contents |
| --- | --- |
| `contracts/` | Schemas, examples and Go types shared by Systems and ML |
| `cmd/aqos-testbed`, `internal/testbed` | The emulated home network |
| `internal/extract`, `internal/netfilter`, `internal/capture`, `cmd/aqos-extract` | Feature extractor, offline and live |
| `internal/cake`, `internal/exporter`, `configs/baselines/`, `dashboards/` | Baselines and metrics |
| `ml/aqos_ml/run` | Experiment runner |
| `ml/aqos_ml/dataset` | Dataset builder |
| `ml/aqos_ml/rules.py`, `ml/aqos_ml/evaluate.py` | Threshold rules and the shared scoring code |
| `internal/enforce`, `cmd/aqos-ctl` | Enforcer |
| `cmd/aqos-watchdog`, `internal/heartbeat` | Watchdog |
| `ml/aqos_ml/features.py`, `train.py`, `model.py`, `serve.py` | Classifier and the ML service |
| `ml/aqos_ml/damage.py`, `configs/damage_*.yaml` | Damage table, measured |
| `ml/aqos_ml/decide.py` | Decision engine |
| `internal/shield`, `configs/shield.yaml` | Safety shield |
| `cmd/aqosd`, `internal/controller` | The controller |
| `ml/aqos_ml/compare.py` | Models against rules, the go/no-go report |
| `ml/aqos_ml/gen` | Traffic generators |
| `ml/aqos_ml/capture.py` | Recording and reviewing real-app captures |
| `scenarios/` | Scenario files |
| `kaggle/` | Reducing public datasets to flow tables |
| `ml/tests/` | Python tests |
| `scripts/` | Environment check, data fetching, the demo, the frozen-system runs |
| `reports/` | The report, result summaries and charts, the one-slide and round-1 slides, the explainer video's sources |
| `docs/images/` | Figures used in this README |

</details>
