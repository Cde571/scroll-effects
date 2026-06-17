@echo off
cd /d %~dp0
echo COSMIC NEXUS - Immersive Scroll Atlas V8
echo Abre http://localhost:5500
py -m http.server 5500
