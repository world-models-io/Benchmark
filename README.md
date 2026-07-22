# World Models Benchmark Evidence

This public repository stores immutable, inspectable evidence for benchmark reproductions published by World Models. It is deliberately separate from the website, model index, and source implementations.

## Licence

The documentation, manifests, hashes, and raw evaluation logs in this repository are released under [Creative Commons Attribution 4.0 International](LICENSE) (CC BY 4.0). Attribution must preserve the run identifier, protocol, source implementation, and evidence-release URL. Third-party model checkpoints and Atari ROMs are not relicensed by this repository and are never redistributed here.

## What belongs here

- completed run manifests;
- environment locks and dependency versions;
- checkpoint and ROM hashes;
- raw per-seed evaluation logs;
- release notes describing the protocol and any author/reproduction delta.

## What must never be committed or uploaded

- Atari ROM files;
- model checkpoints, unless their redistribution licence explicitly permits it;
- credentials, access tokens, local paths, or machine-specific secrets;
- paper-reported values presented as executed runs.

## Publication contract

A result may be labelled `reproduced` only when a completed manifest and immutable raw logs exist. The run must use a registered protocol, its exact metric and unit, a source-backed implementation, a pinned checkpoint SHA-256, recorded environment and hardware, explicit task set and observation mode, and every required seed.

Author-reported values remain separate evidence. Never overwrite them; record the author/reproduction delta instead.

## Releases

Each completed reproduction is released as a versioned evidence bundle. A bundle contains:

1. `manifest.json` — the completed run manifest;
2. `environment.lock` — Python, CUDA, GPU driver, PyTorch and dependency versions;
3. `checkpoints.json` — official checkpoint URLs, source revision and SHA-256 values;
4. `roms.json` — task-set and ROM hashes, without ROM files;
5. `raw-logs/` — one compressed raw log per game and seed;
6. `README.md` — exact commands, result aggregation, and author/reproduction delta.

Raw logs are uploaded as release assets only after their checksums are recorded in the manifest. Publish the release only once every required asset is present.

## IRIS Atari 100K pilot

The first pilot is IRIS under `model-based-rl/atari-100k/v1`:

- metric: `Mean HNS`;
- unit: `x human`;
- required seeds: `0, 1, 2, 3, 4`;
- task set: the official 26 Atari 100K games;
- official implementation: <https://github.com/eloialonso/iris>;
- official checkpoint revision: `c0539e99adf924d44be0f19b12de00639daa5550`.

See [runs/iris-atari-100k-v1/README.md](runs/iris-atari-100k-v1/README.md) for the execution-specific instructions.
