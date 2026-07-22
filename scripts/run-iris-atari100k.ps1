param(
  [string]$IrisRoot = 'H:\benchmark-runtimes\iris',
  [int]$Episodes = 100,
  [int]$NumEnvs = 8
)

$ErrorActionPreference = 'Stop'
$python = Join-Path $IrisRoot '.venv-modern\Scripts\python.exe'
$checkpoints = Join-Path $IrisRoot 'checkpoints\atari100k-v1'
$outputRoot = Join-Path $IrisRoot 'protocol-runs\iris-atari100k-v1-r1'
New-Item -ItemType Directory -Force -Path $outputRoot | Out-Null

foreach ($checkpoint in Get-ChildItem -File -LiteralPath $checkpoints | Sort-Object Name) {
  $game = $checkpoint.BaseName
  $environmentId = "$game`NoFrameskip-v4"
  foreach ($seed in 0..4) {
    $runId = "$game-seed-$seed"
    $runDir = Join-Path $outputRoot $runId
    $logPath = Join-Path $outputRoot "$runId.log"
    New-Item -ItemType Directory -Force -Path $runDir | Out-Null
    & $python src\main.py "hydra.run.dir=$runDir" "initialization.path_to_checkpoint=$($checkpoint.FullName)" initialization.load_tokenizer=True initialization.load_world_model=False initialization.load_actor_critic=True common.epochs=1 common.device=cuda:0 common.do_checkpoint=False "common.seed=$seed" "env.train.id=$environmentId" "collection.test.num_envs=$NumEnvs" "collection.test.config.num_episodes=$Episodes" collection.test.num_episodes_to_save=0 training.should=False evaluation.should=True evaluation.every=1 evaluation.tokenizer.start_after_epochs=1 evaluation.tokenizer.save_reconstructions=False evaluation.world_model.start_after_epochs=1 evaluation.actor_critic.start_after_epochs=1 wandb.mode=disabled *>&1 | Tee-Object -FilePath $logPath
    if ($LASTEXITCODE -ne 0) { throw "run failed: $runId" }
  }
}
