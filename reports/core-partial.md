# Matrix results: `results-core/`

Lower is better everywhere. Cost is 0 for as good as it gets and 1 for unusable, per traffic entry, summed over a scenario's entries. Intervals are 95% bootstrap intervals of the median over seeds. A comparison reads "verdict: median paired difference (interval), p, r"; negative means the first configuration is better; r is the rank-biserial effect size, -1 when it was better on every seed.

## Runs

| Scenario | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- |
| S1 Large download starts during a video call | 5 | 5 | 5 | 5 | 5 |
| S2 WAN drops from 100 to 20 Mbit/s | 5 | 5 | 5 | 5 | 5 |
| S3 Three TVs streaming plus a gaming device | 5 | 5 | 5 | 5 | 5 |
| S4 Cloud backup saturates the upload during gaming | 5 | 5 | 5 | 5 | 5 |
| S5 Priority for the work laptop during a busy evening | 5 | 5 | 5 | 5 | 5 |
| S6 HD video call on a laptop that is also sharing files | 6 | 6 | 6 | 6 | 6 |
| S7 Cloud gaming on a PC that is also fetching a game update | 6 | 6 | 6 | 6 | 6 |
| S8 Flows that change what they are | 6 | 6 | 6 | 5 | 5 |
| S10 The delay probes go silent, then the controller is killed | 5 | 5 | 5 | 5 | 5 |

Valid runs per scenario and configuration. No A/A runs: differences are judged against zero.

## Summed cost, configuration against configuration

| Scenario | O2 against B4 | O2 against O1 | O2 against B2 | O1 against B2 | B4 against B2 | B2 against B0 |
| --- | --- | --- | --- | --- | --- | --- |
| S1 | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: -1.00 (-1.00 to -1.00), r -1.00 |
| S2 | too few seeds: -1.00 (-1.00 to -1.00), r -1.00 | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: -1.00 (-1.00 to -1.00), r -1.00 | too few seeds: -1.00 (-1.00 to -1.00), r -1.00 | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) |
| S3 | too few seeds: +0.00 (-0.23 to +0.00), r -1.00 | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.23), r +1.00 | too few seeds: -1.00 (-1.00 to -1.00), r -1.00 |
| S4 | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: -1.00 (-1.00 to -1.00), r -1.00 |
| S5 | too few seeds: -2.00 (-2.04 to -0.82), r -1.00 | too few seeds: -0.75 (-1.02 to +0.14), r -0.73 | too few seeds: -1.00 (-1.00 to +0.18), r -0.87 | too few seeds: +0.00 (-1.00 to +0.04), r -0.40 | too few seeds: +1.00 (+1.00 to +1.05), r +1.00 | too few seeds: -1.00 (-1.01 to -1.00), r -1.00 |
| S6 | better: -0.96 (-0.97 to -0.96), p 0.031, r -1.00 | tie: -0.04 (-0.35 to +0.04), p 0.406, r -0.43 | better: -0.96 (-0.97 to -0.96), p 0.250, r -1.00 | better: -0.91 (-1.00 to -0.62), p 0.250, r -1.00 | tie: +0.00 (+0.00 to +0.00) | better: -0.37 (-0.52 to -0.23), p 0.250, r -1.00 |
| S7 | better: -1.00 (-1.00 to -0.74), p 0.031, r -1.00 | tie: +0.00 (-0.24 to +0.17), p 1.000, r -0.33 | better: -1.00 (-1.00 to -0.74), p 0.250, r -1.00 | better: -1.00 (-1.00 to -0.67), p 0.250, r -1.00 | tie: +0.00 (+0.00 to +0.00) | tie: -0.01 (-0.04 to +0.00), p 0.250, r -1.00 |
| S8 | too few seeds: -1.07 (-1.10 to -0.48), r -1.00 | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: -1.00 (-1.00 to -0.37), r -1.00 | too few seeds: -1.00 (-1.00 to -0.37), r -1.00 | worse: +0.09 (+0.02 to +0.14), p 0.250, r +0.90 | better: -1.27 (-1.69 to -1.07), p 0.250, r -1.00 |
| S10 | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: +0.00 (+0.00 to +0.00) | too few seeds: -1.00 (-1.00 to -1.00), r -1.00 |

O2 against B4 and O2 against O1 were named in advance; the p-values of the others are Holm-corrected.

## Summed cost, median over seeds

| Scenario | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- |
| S1 | 1.00 (1.00 to 1.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) |
| S2 | 1.00 (1.00 to 1.00) | 1.00 (1.00 to 1.00) | 1.00 (1.00 to 1.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) |
| S3 | 1.31 (1.19 to 1.38) | 0.31 (0.19 to 0.38) | 0.33 (0.19 to 0.53) | 0.31 (0.19 to 0.38) | 0.31 (0.19 to 0.38) |
| S4 | 1.00 (1.00 to 1.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) |
| S5 | 2.31 (2.19 to 2.39) | 1.31 (1.19 to 1.38) | 2.31 (2.24 to 2.38) | 1.22 (0.34 to 1.42) | 0.31 (0.20 to 1.56) |
| S6 | 1.37 (1.23 to 1.52) | 1.00 (1.00 to 1.00) | 1.00 (1.00 to 1.00) | 0.09 (0.00 to 0.38) | 0.04 (0.03 to 0.04) |
| S7 | 1.09 (1.07 to 1.16) | 1.09 (1.06 to 1.12) | 1.09 (1.06 to 1.12) | 0.10 (0.06 to 0.45) | 0.11 (0.06 to 0.36) |
| S8 | 2.30 (2.15 to 2.47) | 1.05 (0.73 to 1.10) | 1.16 (0.77 to 1.21) | 0.08 (0.05 to 0.13) | 0.08 (0.05 to 0.13) |
| S10 | 1.00 (1.00 to 1.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) | 0.00 (0.00 to 0.00) |

## Calls and games

| Scenario | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| S1 | call: late frames % | 77.0 (76.9 to 77.0) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.1) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) |
| S1 | call: latency p95 ms | 505.1 (410.0 to 506.0) | 11.7 (11.3 to 12.5) | 11.7 (11.2 to 12.5) | 11.7 (11.2 to 12.5) | 11.7 (11.2 to 12.5) |
| S2 | call: late frames % | 77.0 (76.9 to 77.0) | 55.5 (55.5 to 55.5) | 55.6 (55.5 to 55.6) | 1.0 (0.9 to 1.0) | 1.0 (0.9 to 1.0) |
| S2 | call: latency p95 ms | 506.8 (505.6 to 508.1) | 502.9 (499.4 to 503.8) | 498.7 (497.7 to 504.1) | 22.1 (18.4 to 22.8) | 20.4 (18.1 to 24.3) |
| S3 | game: late frames % | 66.0 (42.7 to 69.8) | 0.0 (0.0 to 0.0) | 0.4 (0.0 to 5.3) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) |
| S3 | game: latency p95 ms | 404.8 (329.1 to 423.0) | 17.2 (15.0 to 18.2) | 33.7 (26.1 to 51.4) | 16.5 (15.0 to 18.3) | 16.2 (14.6 to 18.6) |
| S4 | game: late frames % | 77.7 (77.7 to 77.7) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) |
| S4 | game: latency p95 ms | 507.0 (506.7 to 507.2) | 11.3 (11.3 to 11.3) | 11.3 (11.3 to 11.3) | 11.3 (11.3 to 11.3) | 11.3 (11.3 to 11.3) |
| S5 | call: late frames % | 93.5 (93.1 to 94.3) | 93.1 (57.4 to 94.4) | 71.4 (66.7 to 93.7) | 27.5 (1.1 to 91.1) | 0.1 (0.0 to 44.5) |
| S5 | call: latency p95 ms | 488.4 (483.7 to 492.5) | 35.6 (34.8 to 37.1) | 1,356.7 (317.6 to 2,223.5) | 55.7 (34.9 to 116.6) | 29.5 (20.8 to 84.7) |
| S5 | game: late frames % | 94.1 (93.8 to 94.4) | 0.0 (0.0 to 0.0) | 35.7 (21.5 to 43.0) | 0.0 (0.0 to 0.1) | 0.0 (0.0 to 0.0) |
| S5 | game: latency p95 ms | 489.7 (484.2 to 492.5) | 19.0 (18.4 to 19.9) | 91.8 (88.3 to 691.3) | 18.8 (18.2 to 23.4) | 19.1 (18.5 to 22.4) |
| S6 | call: late frames % | 94.3 (94.1 to 94.3) | 94.3 (94.2 to 94.3) | 94.4 (94.3 to 94.4) | 2.6 (0.7 to 8.2) | 1.7 (1.5 to 1.8) |
| S6 | call: latency p95 ms | 505.0 (504.3 to 505.1) | 1,785.5 (1,672.8 to 1,837.6) | 2,063.1 (1,928.5 to 2,349.6) | 24.4 (24.2 to 25.5) | 16.7 (16.7 to 17.2) |
| S7 | game: late frames % | 83.7 (83.4 to 83.8) | 83.2 (83.0 to 83.2) | 19.4 (19.3 to 19.5) | 0.5 (0.2 to 7.3) | 0.6 (0.2 to 5.9) |
| S7 | game: latency p95 ms | 507.2 (506.3 to 507.6) | 924.7 (743.0 to 1,244.3) | 22.0 (18.0 to 23.7) | 17.9 (14.7 to 26.8) | 17.9 (14.8 to 25.8) |
| S8 | call: late frames % | 64.5 (58.1 to 65.9) | 39.2 (13.3 to 64.9) | 23.6 (8.0 to 59.3) | 0.2 (0.0 to 0.6) | 0.0 (0.0 to 0.0) |
| S8 | call: latency p95 ms | 500.2 (497.4 to 502.4) | 32.5 (31.6 to 35.7) | 77.1 (54.0 to 1,064.9) | 14.9 (13.5 to 17.0) | 12.5 (12.0 to 13.6) |
| S8 | game: late frames % | 63.6 (60.9 to 64.4) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) |
| S8 | game: latency p95 ms | 503.6 (499.5 to 504.7) | 11.5 (11.2 to 12.0) | 11.1 (10.8 to 13.7) | 13.4 (11.9 to 13.5) | 11.5 (10.7 to 14.7) |
| S10 | call: late frames % | 77.0 (76.9 to 77.0) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.1) | 0.0 (0.0 to 0.0) | 0.0 (0.0 to 0.0) |
| S10 | call: latency p95 ms | 505.7 (410.0 to 506.2) | 11.7 (11.3 to 12.5) | 11.7 (11.2 to 12.5) | 11.6 (11.2 to 12.4) | 11.6 (11.2 to 12.4) |

## What the controller did, mean per run

| Scenario | Configuration | labelled | relabelled | triggers | rechecks | rate_changes | watched | regressed | rolled_back | rejected |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S1 | B4 | 8.4 | 4.2 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S1 | O1 | 4.2 | 0.0 | 10.4 | 10.2 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| S1 | O2 | 4.2 | 0.0 | 10.6 | 9.0 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| S2 | B4 | 8.4 | 4.2 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| S2 | O1 | 4.2 | 0.0 | 9.2 | 9.6 | 19.8 | 10.0 | 0.0 | 0.0 | 0.0 |
| S2 | O2 | 4.2 | 0.0 | 9.2 | 10.0 | 20.2 | 10.0 | 0.0 | 0.0 | 0.0 |
| S3 | B4 | 8.0 | 4.0 | 0.0 | 0.0 | 0.0 | 0.8 | 0.0 | 0.0 | 0.0 |
| S3 | O1 | 7.6 | 3.6 | 16.8 | 11.0 | 6.6 | 9.2 | 0.2 | 0.2 | 0.0 |
| S3 | O2 | 5.0 | 1.0 | 7.8 | 13.0 | 5.0 | 4.8 | 0.0 | 0.0 | 0.2 |
| S4 | B4 | 5.2 | 2.6 | 0.0 | 0.0 | 0.0 | 0.8 | 0.0 | 0.0 | 0.0 |
| S4 | O1 | 5.0 | 2.4 | 13.0 | 2.0 | 0.0 | 1.4 | 0.0 | 0.0 | 0.6 |
| S4 | O2 | 3.0 | 0.4 | 14.0 | 3.2 | 0.0 | 1.2 | 0.0 | 0.0 | 0.2 |
| S5 | B4 | 16.0 | 9.0 | 0.0 | 0.0 | 0.0 | 1.8 | 0.0 | 0.0 | 2.0 |
| S5 | O1 | 11.2 | 4.2 | 45.4 | 13.8 | 25.6 | 20.6 | 0.4 | 0.0 | 0.0 |
| S5 | O2 | 8.6 | 1.6 | 32.6 | 15.8 | 20.6 | 17.4 | 0.0 | 0.0 | 0.0 |
| S6 | B4 | 73.3 | 40.3 | 0.0 | 0.0 | 0.0 | 2.8 | 0.0 | 0.0 | 9.5 |
| S6 | O1 | 46.2 | 13.2 | 129.2 | 68.2 | 9.0 | 12.5 | 1.7 | 0.8 | 0.0 |
| S6 | O2 | 36.2 | 3.2 | 135.2 | 66.3 | 8.0 | 8.2 | 0.0 | 0.0 | 0.0 |
| S7 | B4 | 22.0 | 12.0 | 0.0 | 0.0 | 0.0 | 1.0 | 0.0 | 0.0 | 1.0 |
| S7 | O1 | 10.8 | 0.8 | 13.0 | 28.7 | 3.2 | 4.2 | 0.0 | 0.0 | 0.0 |
| S7 | O2 | 10.0 | 0.0 | 7.2 | 29.0 | 4.0 | 3.8 | 0.0 | 0.0 | 0.0 |
| S8 | B4 | 80.5 | 47.5 | 0.0 | 0.0 | 0.0 | 5.7 | 0.0 | 0.0 | 15.7 |
| S8 | O1 | 47.0 | 13.2 | 116.0 | 71.6 | 8.0 | 12.4 | 0.0 | 0.0 | 0.2 |
| S8 | O2 | 37.4 | 3.6 | 103.8 | 78.2 | 8.0 | 9.4 | 0.0 | 0.0 | 0.2 |

