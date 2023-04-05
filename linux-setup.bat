@echo off
cd /d %~dp0
wsl --set-default docker-desktop > nul
wsl bash ./linux-setup
