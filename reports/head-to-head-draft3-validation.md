# Offline head-to-head: draft3, validation split

Dataset `draft3` (sha256 `d70c179b230d`), 3488 flows from 313 sessions. Damage table: `damage_table.yaml` (measured). Every flow counts once and every class counts the same.

**Draft. Not a result.** Dataset `draft3` is incomplete (the cloud-gaming and bulk-download sets were still arriving) and the damage table had one seed per cell. This shows that the comparison runs and roughly what to expect; the numbers to quote come from dataset `v1`.

## Verdict: go

- LightGBM, expected damage (O2) has lower balanced expected damage than the tuned rules: 0.002 against 0.224 (difference -0.222, 95% interval -0.258 to -0.186).
- Video calls (443 flows): damage 0.00 against the rules' 0.00; sent to Bulk 0% against 0%.
- Cloud gaming (9 flows): damage 0.00 against the rules' 0.31; sent to Bulk 0% against 0%.

## Scores

| Contestant | Balanced expected damage | Against tuned rules (95% interval) | Accuracy | Macro-F1 | Calibration error |
| --- | --- | --- | --- | --- | --- |
| Rules, qosify defaults | 1.795 | +1.571 (+1.228 to +1.855) | 0.475 | 0.116 |  |
| Rules, tuned (4000 pkt/s, 1200 B) | 0.224 |  | 0.414 | 0.097 |  |
| Random forest, top label (O1) | 0.090 | -0.134 (-0.209 to -0.042) | 0.978 | 0.799 | 0.020 |
| Random forest, expected damage (O2) | 0.016 | -0.208 (-0.240 to -0.177) | 0.978 | 0.799 | 0.020 |
| LightGBM, top label (O1) | 0.137 | -0.087 (-0.217 to +0.086) | 0.967 | 0.754 | 0.025 |
| LightGBM, expected damage (O2) | 0.002 | -0.222 (-0.258 to -0.186) | 0.967 | 0.754 | 0.025 |

Lower damage is better. The interval comes from resampling whole sessions 2,000 times; one that stays below zero means the contestant beats the tuned rules.

## Expected damage by true class

| Contestant | telephony | realtime_interactive | multimedia_conferencing | multimedia_streaming | standard | high_throughput_data | low_priority_data |
| --- | --- | --- | --- | --- | --- | --- | --- |
| *flows* | 19 | 14 | 443 | 23 | 2843 | 45 | 101 |
| Rules, qosify defaults | 0.00 | 4.84 | 0.37 | 1.79 | 0.00 | 5.48 | 0.08 |
| Rules, tuned (4000 pkt/s, 1200 B) | 0.00 | 0.34 | 0.00 | 0.41 | 0.00 | 0.39 | 0.42 |
| Random forest, top label (O1) | 0.00 | 0.19 | 0.00 | 0.21 | 0.00 | 0.21 | 0.01 |
| Random forest, expected damage (O2) | 0.00 | 0.01 | 0.00 | 0.09 | 0.00 | 0.00 | 0.01 |
| LightGBM, top label (O1) | 0.00 | 0.40 | 0.00 | 0.15 | 0.01 | 0.40 | 0.00 |
| LightGBM, expected damage (O2) | 0.00 | 0.00 | 0.00 | 0.01 | 0.00 | 0.00 | 0.00 |

## The traffic the project is about

| Contestant | Video calls: sent to Bulk | Video calls: damage | Cloud gaming: sent to Bulk | Cloud gaming: damage |
| --- | --- | --- | --- | --- |
| Rules, qosify defaults | 15% of 443 | 0.37 | 69% of 9 | 4.42 |
| Rules, tuned (4000 pkt/s, 1200 B) | 0% of 443 | 0.00 | 0% of 9 | 0.31 |
| Random forest, top label (O1) | 0% of 443 | 0.00 | 0% of 9 | 0.30 |
| Random forest, expected damage (O2) | 0% of 443 | 0.00 | 0% of 9 | 0.02 |
| LightGBM, top label (O1) | 0% of 443 | 0.00 | 0% of 9 | 0.62 |
| LightGBM, expected damage (O2) | 0% of 443 | 0.00 | 0% of 9 | 0.00 |

## Where each class's flows were sent

**Rules, qosify defaults**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 43% | 0% | 57% | 0% | 0.00 |
| realtime_interactive | 14% | 0% | 11% | 75% | 0.14 |
| multimedia_conferencing | 37% | 0% | 48% | 15% | 0.00 |
| multimedia_streaming | 4% | 0% | 41% | 56% | 0.00 |
| standard | 42% | 0% | 58% | 0% | 0.58 |
| high_throughput_data | 4% | 0% | 35% | 61% | 0.00 |
| low_priority_data | 16% | 0% | 70% | 14% | 0.14 |

**Rules, tuned (4000 pkt/s, 1200 B)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 45% | 0% | 55% | 0% | 0.00 |
| realtime_interactive | 89% | 0% | 11% | 0% | 0.89 |
| multimedia_conferencing | 96% | 0% | 4% | 0% | 0.00 |
| multimedia_streaming | 59% | 0% | 41% | 0% | 0.00 |
| standard | 50% | 0% | 50% | 0% | 0.50 |
| high_throughput_data | 78% | 0% | 22% | 0% | 0.00 |
| low_priority_data | 85% | 0% | 15% | 0% | 0.00 |

**Random forest, top label (O1)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 34% | 11% | 55% | 0% | 0.34 |
| realtime_interactive | 81% | 13% | 6% | 0% | 0.81 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 0% | 79% | 21% | 0% | 0.79 |
| standard | 0% | 0% | 100% | 0% | 0.99 |
| high_throughput_data | 0% | 0% | 97% | 2% | 0.93 |
| low_priority_data | 0% | 2% | 28% | 70% | 0.77 |

**Random forest, expected damage (O2)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 34% | 11% | 55% | 0% | 0.34 |
| realtime_interactive | 92% | 7% | 0% | 0% | 0.81 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 16% | 75% | 9% | 0% | 0.79 |
| standard | 1% | 7% | 92% | 0% | 0.99 |
| high_throughput_data | 1% | 0% | 99% | 0% | 0.93 |
| low_priority_data | 2% | 0% | 98% | 0% | 0.77 |

**LightGBM, top label (O1)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 53% | 11% | 37% | 0% | 0.53 |
| realtime_interactive | 79% | 8% | 13% | 0% | 0.79 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 0% | 85% | 15% | 0% | 0.85 |
| standard | 1% | 1% | 98% | 0% | 0.98 |
| high_throughput_data | 0% | 0% | 96% | 4% | 0.95 |
| low_priority_data | 1% | 0% | 34% | 65% | 0.70 |

**LightGBM, expected damage (O2)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 53% | 11% | 37% | 0% | 0.53 |
| realtime_interactive | 100% | 0% | 0% | 0% | 0.79 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 11% | 89% | 1% | 0% | 0.85 |
| standard | 4% | 6% | 90% | 0% | 0.98 |
| high_throughput_data | 0% | 0% | 100% | 0% | 0.95 |
| low_priority_data | 1% | 0% | 99% | 0% | 0.70 |

## Has the model learned the lab?

LightGBM trained without each source in turn, then scored on that source's flows by expected damage. A class the model can only place when it has seen that source's own recordings shows up here as high damage.

| Source left out | Flows | Damage by class on that source |
| --- | --- | --- |
| iscx-tor-nontor-2016 | 1593 | high_throughput_data 0.00 (2), standard 0.00 (1591) |
| iscx-vpn-nonvpn-2016 | 255 | high_throughput_data 0.00 (5), multimedia_streaming 0.20 (5), standard 0.00 (229), telephony 0.00 (16) |
| labayen-2020 | 825 | multimedia_streaming 0.00 (13), standard 0.00 (812) |
| own-captures | 3 | realtime_interactive 1.14 (3) |
| purdue-vca-2026 | 437 | multimedia_conferencing 0.00 (437) |
| testbed | | Skipped: a class would have no data left without this source |

