# IRIS Atari 100K v1 — execution runbook

**Status:** pre-execution evidence is complete; no evaluation score is published by this document.

This runbook is the evidence contract for the first IRIS reproduction. It uses the protocol registered by the World Models website as `model-based-rl/atari-100k/v1`.

## Pinned sources

- Implementation: <https://github.com/eloialonso/iris>
- Implementation commit: `24326aaaa283c527f42b89b44cfdecf2665a7a16`
- Official checkpoint repository: <https://huggingface.co/eloialonso/iris>
- Checkpoint repository revision: `c0539e99adf924d44be0f19b12de00639daa5550`
- Checkpoint scope: 26 official game-specific `.pt` files, each verified locally against its published LFS SHA-256.

## Required protocol

- Task set: Alien, Amidar, Assault, Asterix, Bank Heist, Battle Zone, Boxing, Breakout, Chopper Command, Crazy Climber, Demon Attack, Freeway, Frostbite, Gopher, Hero, James Bond, Kangaroo, Krull, Kung-Fu Master, Ms. Pacman, Pong, Private Eye, Q*bert, Road Runner, Seaquest, and Up N Down.
- Evaluation seeds: `0`, `1`, `2`, `3`, `4`.
- Observation: 64×64 RGB observations, `frame_skip=4`, test `noop_max=1`, no life-loss termination, maximum 108,000 test steps.
- Result: compute `Mean HNS` in `x human` from the complete 26-game × 5-seed output. Do not publish a partial-game score.

## Runtime disclosure

IRIS documents PyTorch 1.11 / CUDA 11.3. The execution machine uses an RTX 5070 (`sm_120`), which cannot run that historical wheel. The reproduction therefore uses a pinned modern runtime:

- Python 3.10;
- PyTorch `2.11.0+cu128` and torchvision `0.26.0+cu128`;
- Gym `0.21.0`, ALE `0.7.4`, NumPy `1.26.4`, OpenCV `4.5.5`;
- NVIDIA RTX 5070 with its driver version recorded at execution time.

This is a disclosed runtime delta, not an author-runtime claim. It is eligible for a reproduction record only if every requirement in this runbook and the protocol is satisfied.

## Before execution

1. `environment.lock`, `checkpoints.json`, and `roms.json` record the local runtime, all 26 verified checkpoint hashes, and all 26 accepted ROM hashes.
2. The checkpoint inventory is verified against the official Hugging Face LFS object IDs.
3. Use an officially licensed Atari ROM installation. Do not upload ROMs.
4. Run each game/checkpoint under every required seed and retain stdout, stderr, structured episode returns, and the exact command.
5. Store raw logs in the versioned draft release; do not publish the release until all 130 runs are present.

## Publication gate

Before publishing the `IRIS Atari 100K reproduction r1` release, the remaining work is:

1. Add the completed manifest, environment lock, checkpoint inventory, ROM-hash inventory and raw logs.
2. Verify that all 130 game/seed runs completed and their asset checksums match the manifest.
3. Calculate the result from those logs and document the author/reproduction delta.
4. Publish the release, then add the source-backed `reproduced` record to the website without replacing the author-reported record.
