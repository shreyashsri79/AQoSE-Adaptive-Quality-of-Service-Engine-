# Matrix results: `results-smoke/`

Lower is better everywhere. Cost is 0 for as good as it gets and 1 for unusable, per traffic entry, summed over a scenario's entries. Intervals are 95% bootstrap intervals of the median over seeds. A comparison reads "verdict: median paired difference (interval), p, r"; negative means the first configuration is better; r is the rank-biserial effect size, -1 when it was better on every seed.

## Runs

| Scenario | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- |
| S1 Large download starts during a video call | 1 | 1 | 1 | 1 | 1 |
| S2 WAN drops from 100 to 20 Mbit/s | 1 | 1 | 1 | 1 | 1 |
| S3 Three TVs streaming plus a gaming device | 1 | 1 | 1 | 1 | 1 |
| S4 Cloud backup saturates the upload during gaming | 1 | 1 | 1 | 1 | 1 |
| S5 Priority for the work laptop during a busy evening | 1 | 1 | 1 | 1 | 1 |
| S6 HD video call on a laptop that is also sharing files | 1 | 1 | 1 | 1 | 1 |
| S7 Cloud gaming on a PC that is also fetching a game update | 1 | 1 | 1 | 1 | 1 |
| S8 Flows that change what they are | 1 | 1 | 1 | 1 | 1 |
| S10 The delay probes go silent, then the controller is killed | 1 | 1 | 1 | 1 | 1 |

Valid runs per scenario and configuration. No A/A runs: differences are judged against zero.

## Summed cost, configuration against configuration

| Scenario | O2 against B4 | O2 against O1 | O2 against B2 | O1 against B2 | B4 against B2 | B2 against B0 |
| --- | --- | --- | --- | --- | --- | --- |
| S1 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: -1.00, r -1.00 |
| S2 | too few seeds: -1.00, r -1.00 | too few seeds: -0.00, r -1.00 | too few seeds: -1.00, r -1.00 | too few seeds: -1.00, r -1.00 | too few seeds: +0.00 | too few seeds: +0.00 |
| S3 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: -1.00, r -1.00 |
| S4 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: -1.00, r -1.00 |
| S5 | too few seeds: -2.03, r -1.00 | too few seeds: -0.99, r -1.00 | too few seeds: -0.98, r -1.00 | too few seeds: +0.00, r +1.00 | too few seeds: +1.05, r +1.00 | too few seeds: -1.00, r -1.00 |
| S6 | too few seeds: -0.97, r -1.00 | too few seeds: -0.46, r -1.00 | too few seeds: -0.97, r -1.00 | too few seeds: -0.51, r -1.00 | too few seeds: +0.00 | too few seeds: -0.29, r -1.00 |
| S7 | too few seeds: -1.00, r -1.00 | too few seeds: +0.00, r +1.00 | too few seeds: -1.00, r -1.00 | too few seeds: -1.00, r -1.00 | too few seeds: +0.00 | too few seeds: -0.01, r -1.00 |
| S8 | too few seeds: -0.62, r -1.00 | too few seeds: +0.00 | too few seeds: -1.00, r -1.00 | too few seeds: -1.00, r -1.00 | too few seeds: -0.38, r -1.00 | too few seeds: -1.05, r -1.00 |
| S10 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: +0.00 | too few seeds: -1.00, r -1.00 |

O2 against B4 and O2 against O1 were named in advance; the p-values of the others are Holm-corrected.

## Summed cost, median over seeds

| Scenario | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- |
| S1 | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| S2 | 1.00 | 1.00 | 1.00 | 0.00 | 0.00 |
| S3 | 1.19 | 0.19 | 0.19 | 0.19 | 0.19 |
| S4 | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| S5 | 2.19 | 1.19 | 2.23 | 1.19 | 0.20 |
| S6 | 1.29 | 1.00 | 1.00 | 0.49 | 0.03 |
| S7 | 1.13 | 1.12 | 1.12 | 0.12 | 0.12 |
| S8 | 2.16 | 1.12 | 0.74 | 0.12 | 0.12 |
| S10 | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |

## Calls and games

| Scenario | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| S1 | call: late frames % | 77.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S1 | call: latency p95 ms | 505.5 | 12.5 | 12.5 | 12.5 | 12.4 |
| S2 | call: late frames % | 77.0 | 55.5 | 55.6 | 1.1 | 1.0 |
| S2 | call: latency p95 ms | 507.7 | 501.9 | 503.7 | 18.7 | 19.9 |
| S3 | game: late frames % | 69.3 | 0.0 | 0.1 | 0.0 | 0.0 |
| S3 | game: latency p95 ms | 398.0 | 14.8 | 30.9 | 15.1 | 15.0 |
| S4 | game: late frames % | 77.7 | 0.0 | 0.0 | 0.0 | 0.0 |
| S4 | game: latency p95 ms | 506.8 | 11.3 | 11.3 | 11.3 | 11.3 |
| S5 | call: late frames % | 94.4 | 94.4 | 93.1 | 91.5 | 0.7 |
| S5 | call: latency p95 ms | 484.6 | 37.3 | 2,396.9 | 51.3 | 33.0 |
| S5 | game: late frames % | 94.4 | 0.0 | 40.8 | 0.0 | 0.0 |
| S5 | game: latency p95 ms | 485.7 | 18.8 | 567.2 | 19.1 | 17.8 |
| S6 | call: late frames % | 93.5 | 94.3 | 94.4 | 10.4 | 1.5 |
| S6 | call: latency p95 ms | 504.0 | 1,723.1 | 1,977.6 | 25.4 | 17.2 |
| S7 | game: late frames % | 83.4 | 83.2 | 19.3 | 1.0 | 1.1 |
| S7 | game: latency p95 ms | 507.7 | 1,003.3 | 24.1 | 18.1 | 18.2 |
| S8 | call: late frames % | 60.5 | 39.9 | 10.1 | 0.7 | 0.0 |
| S8 | call: latency p95 ms | 494.7 | 34.7 | 73.8 | 17.1 | 13.6 |
| S8 | game: late frames % | 61.1 | 0.0 | 0.0 | 0.0 | 0.0 |
| S8 | game: latency p95 ms | 499.4 | 11.9 | 12.2 | 13.3 | 11.7 |
| S10 | call: late frames % | 77.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S10 | call: latency p95 ms | 505.6 | 12.4 | 12.5 | 12.4 | 12.4 |

## What the controller did, mean per run

| Scenario | Configuration | labelled | relabelled | triggers | rechecks | rate_changes | watched | regressed | rolled_back | rejected |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S1 | B4 | 10.0 | 5.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S1 | O1 | 5.0 | 0.0 | 8.0 | 12.0 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| S1 | O2 | 5.0 | 0.0 | 8.0 | 11.0 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| S2 | B4 | 10.0 | 5.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S2 | O1 | 5.0 | 0.0 | 8.0 | 14.0 | 20.0 | 10.0 | 0.0 | 0.0 | 0.0 |
| S2 | O2 | 5.0 | 0.0 | 8.0 | 13.0 | 20.0 | 10.0 | 0.0 | 0.0 | 0.0 |
| S3 | B4 | 8.0 | 4.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S3 | O1 | 7.0 | 3.0 | 17.0 | 13.0 | 0.0 | 4.0 | 0.0 | 0.0 | 0.0 |
| S3 | O2 | 4.0 | 0.0 | 14.0 | 11.0 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| S4 | B4 | 4.0 | 2.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S4 | O1 | 3.0 | 1.0 | 14.0 | 1.0 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| S4 | O2 | 2.0 | 0.0 | 14.0 | 0.0 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| S5 | B4 | 16.0 | 9.0 | 0.0 | 0.0 | 0.0 | 1.0 | 0.0 | 0.0 | 2.0 |
| S5 | O1 | 10.0 | 3.0 | 43.0 | 16.0 | 19.0 | 20.0 | 2.0 | 0.0 | 0.0 |
| S5 | O2 | 7.0 | 0.0 | 39.0 | 16.0 | 13.0 | 12.0 | 0.0 | 0.0 | 0.0 |
| S6 | B4 | 57.0 | 27.0 | 0.0 | 0.0 | 0.0 | 2.0 | 0.0 | 0.0 | 0.0 |
| S6 | O1 | 33.0 | 3.0 | 101.0 | 66.0 | 8.0 | 8.0 | 1.0 | 0.0 | 0.0 |
| S6 | O2 | 31.0 | 1.0 | 105.0 | 67.0 | 8.0 | 8.0 | 0.0 | 0.0 | 0.0 |
| S7 | B4 | 22.0 | 12.0 | 0.0 | 0.0 | 0.0 | 1.0 | 0.0 | 0.0 | 1.0 |
| S7 | O1 | 11.0 | 1.0 | 1.0 | 29.0 | 4.0 | 5.0 | 0.0 | 0.0 | 0.0 |
| S7 | O2 | 10.0 | 0.0 | 16.0 | 27.0 | 4.0 | 4.0 | 0.0 | 0.0 | 0.0 |
| S8 | B4 | 77.0 | 45.0 | 0.0 | 0.0 | 0.0 | 7.0 | 0.0 | 0.0 | 15.0 |
| S8 | O1 | 47.0 | 15.0 | 93.0 | 76.0 | 8.0 | 12.0 | 0.0 | 0.0 | 1.0 |
| S8 | O2 | 33.0 | 1.0 | 95.0 | 70.0 | 8.0 | 9.0 | 0.0 | 0.0 | 0.0 |

