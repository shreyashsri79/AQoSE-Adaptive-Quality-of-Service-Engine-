# Offline head-to-head: v1, validation split

Dataset `v1` (sha256 `fe91bbad5e5e`), 3607 flows from 370 sessions. Damage table: `damage_table.yaml` (measured). Every flow counts once and every class counts the same.

## Verdict: go

- LightGBM, expected damage (O2) has lower balanced expected damage than the tuned rules: 0.135 against 1.030 (difference -0.894, 95% interval -0.989 to -0.799).
- Video calls (443 flows): damage 0.01 against the rules' 2.00; sent to Bulk 0% against 0%.
- Cloud gaming (106 flows): damage 0.00 against the rules' 0.83; sent to Bulk 0% against 2%.

## Scores

| Contestant | Balanced expected damage | Against tuned rules (95% interval) | Accuracy | Macro-F1 | Calibration error |
| --- | --- | --- | --- | --- | --- |
| Rules, qosify defaults | 2.154 | +1.125 (+0.875 to +1.393) | 0.460 | 0.110 |  |
| Rules, tuned (4000 pkt/s, 1200 B) | 1.030 |  | 0.418 | 0.104 |  |
| Random forest, top label (O1) | 0.407 | -0.623 (-0.693 to -0.545) | 0.942 | 0.719 | 0.025 |
| Random forest, expected damage (O2) | 0.142 | -0.887 (-0.984 to -0.796) | 0.942 | 0.719 | 0.025 |
| LightGBM, top label (O1) | 0.430 | -0.600 (-0.689 to -0.493) | 0.944 | 0.735 | 0.052 |
| LightGBM, expected damage (O2) | 0.135 | -0.894 (-0.989 to -0.799) | 0.944 | 0.735 | 0.052 |

Lower damage is better. The interval comes from resampling whole sessions 2,000 times; one that stays below zero means the contestant beats the tuned rules.

## Expected damage by true class

| Contestant | telephony | realtime_interactive | multimedia_conferencing | multimedia_streaming | standard | high_throughput_data | low_priority_data |
| --- | --- | --- | --- | --- | --- | --- | --- |
| *flows* | 19 | 111 | 443 | 23 | 2843 | 67 | 101 |
| Rules, qosify defaults | 0.00 | 4.63 | 1.78 | 1.59 | 0.01 | 4.42 | 2.65 |
| Rules, tuned (4000 pkt/s, 1200 B) | 0.00 | 0.81 | 2.00 | 0.21 | 0.00 | 0.78 | 3.41 |
| Random forest, top label (O1) | 0.00 | 0.01 | 0.01 | 1.41 | 0.12 | 0.40 | 0.91 |
| Random forest, expected damage (O2) | 0.00 | 0.03 | 0.01 | 0.02 | 0.02 | 0.02 | 0.89 |
| LightGBM, top label (O1) | 0.00 | 0.00 | 0.01 | 1.41 | 0.13 | 0.43 | 1.03 |
| LightGBM, expected damage (O2) | 0.00 | 0.00 | 0.01 | 0.02 | 0.02 | 0.03 | 0.87 |

## The traffic the project is about

| Contestant | Video calls: sent to Bulk | Video calls: damage | Cloud gaming: sent to Bulk | Cloud gaming: damage |
| --- | --- | --- | --- | --- |
| Rules, qosify defaults | 15% of 443 | 1.78 | 89% of 106 | 4.63 |
| Rules, tuned (4000 pkt/s, 1200 B) | 0% of 443 | 2.00 | 2% of 106 | 0.83 |
| Random forest, top label (O1) | 0% of 443 | 0.01 | 0% of 106 | 0.01 |
| Random forest, expected damage (O2) | 0% of 443 | 0.01 | 1% of 106 | 0.03 |
| LightGBM, top label (O1) | 0% of 443 | 0.01 | 0% of 106 | 0.00 |
| LightGBM, expected damage (O2) | 0% of 443 | 0.01 | 0% of 106 | 0.00 |

## Where each class's flows were sent

**Rules, qosify defaults**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 43% | 0% | 57% | 0% | 0.00 |
| realtime_interactive | 3% | 0% | 8% | 88% | 0.03 |
| multimedia_conferencing | 37% | 0% | 48% | 15% | 0.00 |
| multimedia_streaming | 4% | 0% | 41% | 56% | 0.00 |
| standard | 42% | 0% | 58% | 0% | 0.58 |
| high_throughput_data | 0% | 0% | 41% | 59% | 0.00 |
| low_priority_data | 16% | 0% | 70% | 14% | 0.14 |

**Rules, tuned (4000 pkt/s, 1200 B)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 45% | 0% | 55% | 0% | 0.00 |
| realtime_interactive | 69% | 0% | 29% | 2% | 0.69 |
| multimedia_conferencing | 96% | 0% | 4% | 0% | 0.00 |
| multimedia_streaming | 59% | 0% | 41% | 0% | 0.00 |
| standard | 50% | 0% | 50% | 0% | 0.50 |
| high_throughput_data | 62% | 0% | 32% | 6% | 0.00 |
| low_priority_data | 85% | 0% | 15% | 0% | 0.00 |

**Random forest, top label (O1)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 53% | 11% | 37% | 0% | 0.53 |
| realtime_interactive | 99% | 1% | 0% | 0% | 0.98 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 0% | 91% | 9% | 0% | 0.91 |
| standard | 1% | 3% | 96% | 0% | 0.94 |
| high_throughput_data | 0% | 9% | 91% | 0% | 0.90 |
| low_priority_data | 1% | 3% | 25% | 70% | 0.75 |

**Random forest, expected damage (O2)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 45% | 0% | 37% | 18% | 0.53 |
| realtime_interactive | 99% | 0% | 0% | 1% | 0.98 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 96% | 0% | 4% | 0% | 0.91 |
| standard | 11% | 0% | 88% | 0% | 0.94 |
| high_throughput_data | 4% | 0% | 96% | 0% | 0.90 |
| low_priority_data | 3% | 0% | 27% | 71% | 0.75 |

**LightGBM, top label (O1)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 74% | 16% | 11% | 0% | 0.74 |
| realtime_interactive | 96% | 4% | 0% | 0% | 0.95 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 0% | 91% | 9% | 0% | 0.91 |
| standard | 1% | 3% | 95% | 0% | 0.95 |
| high_throughput_data | 3% | 9% | 88% | 0% | 0.77 |
| low_priority_data | 2% | 3% | 29% | 67% | 0.78 |

**LightGBM, expected damage (O2)**

| True class | voice | video | best_effort | bulk | Recall |
| --- | --- | --- | --- | --- | --- |
| telephony | 66% | 0% | 16% | 18% | 0.74 |
| realtime_interactive | 98% | 2% | 0% | 0% | 0.95 |
| multimedia_conferencing | 0% | 100% | 0% | 0% | 1.00 |
| multimedia_streaming | 96% | 0% | 4% | 0% | 0.91 |
| standard | 10% | 0% | 90% | 0% | 0.95 |
| high_throughput_data | 6% | 0% | 94% | 0% | 0.77 |
| low_priority_data | 2% | 0% | 27% | 71% | 0.78 |

## Has the model learned the lab?

LightGBM trained without each source in turn, then scored on that source's flows by expected damage. A class the model can only place when it has seen that source's own recordings shows up here as high damage.

| Source left out | Flows | Damage by class on that source |
| --- | --- | --- |
| iscx-tor-nontor-2016 | 1591 | standard 0.00 (1591) |
| iscx-vpn-nonvpn-2016 | 273 | high_throughput_data 2.43 (23), multimedia_streaming 0.10 (5), standard 0.77 (229), telephony 0.00 (16) |
| labayen-2020 | 831 | high_throughput_data 0.50 (6), multimedia_streaming 0.06 (13), standard 0.05 (812) |
| own-captures | 3 | realtime_interactive 0.87 (3) |
| purdue-vca-2026 | 437 | multimedia_conferencing 1.66 (437) |
| testbed | | Skipped: a class would have no data left without this source |
| unsw-cloud-gaming-2025 | 97 | realtime_interactive 1.95 (97) |

