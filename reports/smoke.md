# Live runs, side by side

From `results-smoke/`. Cost is 0 for as good as it gets and 1 for unusable, by the thresholds in `damage_scoring.yaml`; a download or a web page is judged against the same one under B2.

## S1: Large download starts during a video call (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| call (video_call) | latency p95 ms | 505.5 | 12.5 | 12.5 | 12.5 | 12.4 |
| call (video_call) | loss % | 0.2 | 0.0 | 0.0 | 0.0 | 0.0 |
| call (video_call) | late frames % | 77.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| call (video_call) | **cost** | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| download (bulk_download) | throughput Mbit/s | 73.0 | 69.3 | 69.3 | 69.3 | 69.3 |
| download (bulk_download) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| *all entries* | **summed cost** | **1.00** | **0.00** | **0.00** | **0.00** | **0.00** |

- B4: 10 labels written, 0 rate changes, 0 proposals rejected by the shield
- O1: 5 labels written, 0 rate changes, 0 proposals rejected by the shield
- O2: 5 labels written, 0 rate changes, 0 proposals rejected by the shield

## S2: WAN drops from 100 to 20 Mbit/s (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| call (video_call) | latency p95 ms | 507.7 | 501.9 | 503.7 | 18.7 | 19.9 |
| call (video_call) | loss % | 1.2 | 0.3 | 0.3 | 0.0 | 0.0 |
| call (video_call) | late frames % | 77.0 | 55.5 | 55.6 | 1.1 | 1.0 |
| call (video_call) | **cost** | 1.00 | 1.00 | 1.00 | 0.00 | 0.00 |
| download (bulk_download) | throughput Mbit/s | 30.6 | 29.5 | 29.4 | 28.7 | 28.6 |
| download (bulk_download) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| *all entries* | **summed cost** | **1.00** | **1.00** | **1.00** | **0.00** | **0.00** |

- B4: 10 labels written, 0 rate changes, 0 proposals rejected by the shield
- O1: 5 labels written, 20 rate changes, 0 proposals rejected by the shield
- O2: 5 labels written, 20 rate changes, 0 proposals rejected by the shield

## S3: Three TVs streaming plus a gaming device (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| stream1 (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream1 (abr_video) | bitrate kbit/s | 5,800.0 | 5,800.0 | 5,800.0 | 5,800.0 | 5,800.0 |
| stream1 (abr_video) | **cost** | 0.03 | 0.03 | 0.03 | 0.03 | 0.03 |
| stream2 (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream2 (abr_video) | bitrate kbit/s | 5,800.0 | 5,800.0 | 5,800.0 | 5,800.0 | 5,800.0 |
| stream2 (abr_video) | **cost** | 0.09 | 0.09 | 0.09 | 0.09 | 0.09 |
| stream3 (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream3 (abr_video) | bitrate kbit/s | 5,800.0 | 5,800.0 | 5,800.0 | 5,800.0 | 5,800.0 |
| stream3 (abr_video) | **cost** | 0.07 | 0.07 | 0.07 | 0.07 | 0.07 |
| game (gaming) | latency p95 ms | 398.0 | 14.8 | 30.9 | 15.1 | 15.0 |
| game (gaming) | loss % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| game (gaming) | late frames % | 69.3 | 0.0 | 0.1 | 0.0 | 0.0 |
| game (gaming) | **cost** | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| *all entries* | **summed cost** | **1.19** | **0.19** | **0.19** | **0.19** | **0.19** |

- B4: 8 labels written, 0 rate changes, 0 proposals rejected by the shield
- O1: 7 labels written, 0 rate changes, 0 proposals rejected by the shield
- O2: 4 labels written, 0 rate changes, 0 proposals rejected by the shield

## S4: Cloud backup saturates the upload during gaming (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| game (gaming) | latency p95 ms | 506.8 | 11.3 | 11.3 | 11.3 | 11.3 |
| game (gaming) | loss % | 0.1 | 0.0 | 0.0 | 0.0 | 0.0 |
| game (gaming) | late frames % | 77.7 | 0.0 | 0.0 | 0.0 | 0.0 |
| game (gaming) | **cost** | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| backup (backup_upload) | throughput Mbit/s | 7.3 | 6.9 | 6.9 | 6.9 | 6.9 |
| backup (backup_upload) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| *all entries* | **summed cost** | **1.00** | **0.00** | **0.00** | **0.00** | **0.00** |

- B4: 4 labels written, 0 rate changes, 0 proposals rejected by the shield
- O1: 3 labels written, 0 rate changes, 0 proposals rejected by the shield
- O2: 2 labels written, 0 rate changes, 0 proposals rejected by the shield

## S5: Priority for the work laptop during a busy evening (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| stream1 (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream1 (abr_video) | bitrate kbit/s | 5,800.0 | 5,800.0 | 5,534.8 | 5,800.0 | 5,800.0 |
| stream1 (abr_video) | **cost** | 0.03 | 0.03 | 0.05 | 0.03 | 0.03 |
| stream2 (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream2 (abr_video) | bitrate kbit/s | 5,800.0 | 5,800.0 | 5,642.5 | 5,750.3 | 5,700.6 |
| stream2 (abr_video) | **cost** | 0.09 | 0.09 | 0.10 | 0.09 | 0.10 |
| stream3 (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream3 (abr_video) | bitrate kbit/s | 5,800.0 | 5,791.7 | 5,617.7 | 5,775.1 | 5,675.7 |
| stream3 (abr_video) | **cost** | 0.07 | 0.07 | 0.08 | 0.07 | 0.08 |
| game (gaming) | latency p95 ms | 485.7 | 18.8 | 567.2 | 19.1 | 17.8 |
| game (gaming) | loss % | 0.1 | 0.0 | 3.8 | 0.0 | 0.0 |
| game (gaming) | late frames % | 94.4 | 0.0 | 40.8 | 0.0 | 0.0 |
| game (gaming) | **cost** | 1.00 | 0.00 | 1.00 | 0.00 | 0.00 |
| call (video_call) | latency p95 ms | 484.6 | 37.3 | 2,396.9 | 51.3 | 33.0 |
| call (video_call) | loss % | 0.8 | 42.4 | 54.1 | 24.2 | 0.0 |
| call (video_call) | late frames % | 94.4 | 94.4 | 93.1 | 91.5 | 0.7 |
| call (video_call) | **cost** | 1.00 | 1.00 | 1.00 | 1.00 | 0.00 |
| backup (backup_upload) | throughput Mbit/s | 1.7 | 2.5 | 2.8 | 1.9 | 1.3 |
| backup (backup_upload) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| *all entries* | **summed cost** | **2.19** | **1.19** | **2.23** | **1.19** | **0.20** |

- B4: 16 labels written, 0 rate changes, 2 proposals rejected by the shield
- O1: 10 labels written, 19 rate changes, 0 proposals rejected by the shield
- O2: 7 labels written, 13 rate changes, 0 proposals rejected by the shield

## S6: HD video call on a laptop that is also sharing files (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| call (video_call) | latency p95 ms | 504.0 | 1,723.1 | 1,977.6 | 25.4 | 17.2 |
| call (video_call) | loss % | 1.1 | 90.9 | 86.5 | 0.5 | 0.1 |
| call (video_call) | late frames % | 93.5 | 94.3 | 94.4 | 10.4 | 1.5 |
| call (video_call) | **cost** | 1.00 | 1.00 | 1.00 | 0.49 | 0.03 |
| sharing (p2p) | throughput Mbit/s | 71.6 | 52.0 | 52.5 | 50.1 | 50.0 |
| sharing (p2p) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| download (bulk_download) | throughput Mbit/s | 22.3 | 42.0 | 41.9 | 39.9 | 40.1 |
| download (bulk_download) | **cost** | 0.29 | 0.00 | 0.00 | 0.00 | 0.00 |
| *all entries* | **summed cost** | **1.29** | **1.00** | **1.00** | **0.49** | **0.03** |

- B4: 57 labels written, 0 rate changes, 0 proposals rejected by the shield
- O1: 33 labels written, 8 rate changes, 0 proposals rejected by the shield
- O2: 31 labels written, 8 rate changes, 0 proposals rejected by the shield

## S7: Cloud gaming on a PC that is also fetching a game update (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| game (cloud_gaming) | latency p95 ms | 507.7 | 1,003.3 | 24.1 | 18.1 | 18.2 |
| game (cloud_gaming) | loss % | 0.2 | 78.0 | 16.1 | 0.0 | 0.0 |
| game (cloud_gaming) | late frames % | 83.4 | 83.2 | 19.3 | 1.0 | 1.1 |
| game (cloud_gaming) | **cost** | 1.00 | 1.00 | 1.00 | 0.00 | 0.00 |
| update (game_update) | throughput Mbit/s | 60.9 | 56.0 | 56.2 | 51.6 | 53.1 |
| update (game_update) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| stream (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream (abr_video) | bitrate kbit/s | 5,592.8 | 5,800.0 | 5,800.0 | 5,800.0 | 5,800.0 |
| stream (abr_video) | **cost** | 0.13 | 0.12 | 0.12 | 0.12 | 0.12 |
| *all entries* | **summed cost** | **1.13** | **1.12** | **1.12** | **0.12** | **0.12** |

- B4: 22 labels written, 0 rate changes, 1 proposals rejected by the shield
- O1: 11 labels written, 4 rate changes, 0 proposals rejected by the shield
- O2: 10 labels written, 4 rate changes, 0 proposals rejected by the shield

## S8: Flows that change what they are (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| call (video_call) | latency p95 ms | 494.7 | 34.7 | 73.8 | 17.1 | 13.6 |
| call (video_call) | loss % | 0.5 | 4.4 | 5.7 | 0.1 | 0.0 |
| call (video_call) | late frames % | 60.5 | 39.9 | 10.1 | 0.7 | 0.0 |
| call (video_call) | **cost** | 1.00 | 1.00 | 0.52 | 0.00 | 0.00 |
| share (p2p) | throughput Mbit/s | 69.0 | 62.2 | 64.9 | 61.1 | 62.4 |
| share (p2p) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| game (gaming) | latency p95 ms | 499.4 | 11.9 | 12.2 | 13.3 | 11.7 |
| game (gaming) | loss % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| game (gaming) | late frames % | 61.1 | 0.0 | 0.0 | 0.0 | 0.0 |
| game (gaming) | **cost** | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| update (game_update) | throughput Mbit/s | 26.3 | 27.9 | 28.2 | 26.4 | 27.2 |
| update (game_update) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| stream (abr_video) | stalled % | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| stream (abr_video) | bitrate kbit/s | 5,085.6 | 5,800.0 | 4,239.8 | 5,800.0 | 5,800.0 |
| stream (abr_video) | **cost** | 0.16 | 0.12 | 0.22 | 0.12 | 0.12 |
| *all entries* | **summed cost** | **2.16** | **1.12** | **0.74** | **0.12** | **0.12** |

- B4: 77 labels written, 0 rate changes, 15 proposals rejected by the shield
- O1: 47 labels written, 8 rate changes, 1 proposals rejected by the shield
- O2: 33 labels written, 8 rate changes, 0 proposals rejected by the shield

## S10: The delay probes go silent, then the controller is killed (seed 1)

| Entry | Measure | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- | --- |
| call (video_call) | latency p95 ms | 505.6 | 12.4 | 12.5 | 12.4 | 12.4 |
| call (video_call) | loss % | 0.3 | 0.0 | 0.0 | 0.0 | 0.0 |
| call (video_call) | late frames % | 77.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| call (video_call) | **cost** | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| download (bulk_download) | throughput Mbit/s | 73.0 | 69.3 | 69.3 | 62.4 | 62.4 |
| download (bulk_download) | **cost** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00 |
| *all entries* | **summed cost** | **1.00** | **0.00** | **0.00** | **0.00** | **0.00** |


## Summed cost over the scenarios run

| | B0 | B2 | B4 | O1 | O2 |
| --- | --- | --- | --- | --- | --- |
| Scenarios | 9 | 9 | 9 | 9 | 9 |
| Mean summed cost | 1.33 | 0.62 | 0.70 | 0.23 | 0.07 |

