$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
Write-Host "COSMIC NEXUS — Immersive Scroll Atlas V8" -ForegroundColor Cyan
Write-Host "Servidor: http://localhost:5500" -ForegroundColor Green
py -m http.server 5500
