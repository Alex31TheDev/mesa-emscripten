$ErrorActionPreference = "Stop"

$SCRIPT_NAME = $MyInvocation.MyCommand.Name
$MODE = if ($args.Count -gt 0) { $args[0] } else { "" }

if ([string]::IsNullOrEmpty($MODE)) {
    [Console]::Error.WriteLine("usage: $SCRIPT_NAME <size|performance>")
    exit 1
}

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $SCRIPT_DIR

Remove-Item -Recurse -Force "build-em" -ErrorAction SilentlyContinue
& (Join-Path $SCRIPT_DIR "build_osmesa_emcc.ps1") $MODE
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$JOBS = [Environment]::ProcessorCount
ninja -C build-em -j$JOBS
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
