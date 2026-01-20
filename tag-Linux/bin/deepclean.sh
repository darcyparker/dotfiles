#!/usr/bin/env bash

# MAINTENANCE SCRIPT FOR SPARSE VHDX
# -------------------------------------------------------------------------
# PREREQUISITE: The 'Sparse' flag must be enabled on the Windows host.
# # TO FULLY SHUTDOWN WSL (from PowerShell):
#   wsl --shutdown
# PowerShell (Admin) commands to enable (one-time setup):
#   wsl --manage <DistroName> --set-sparse true --allow-unsafe
#   wsl --manage Ubuntu --set-sparse true --allow-unsafe
#   wsl --manage docker-desktop --set-sparse true --allow-unsafe
#
# This flag allows the .vhdx file on the C: drive to shrink dynamically
# when the commands below 'trim' the filesystem.
# -------------------------------------------------------------------------

# 1. Notify the Windows Host to reclaim unused blocks from Ubuntu
sudo fstrim -v /

# 2. Delete unused Docker data and notify Windows to reclaim that space too
# Added --volumes to catch hidden disk bloat in Docker
docker system prune -f --volumes

echo "Disk maintenance complete. Your Windows .vhdx files have been shrunk."

# Example commands to check disk size after from powershell, when wsl is shutdown
# -------------------------------------------------------------------------------
#
# $ubuntuPath = "$env:LOCALAPPDATA\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx"
# $dockerPath = "$env:LOCALAPPDATA\Docker\wsl\disk\docker_data.vhdx"
#
# # Function to get the file object
# $uFile = Get-Item $ubuntuPath
# $dFile = Get-Item $dockerPath
#
# # Output results
# Write-Host "--- WSL2 Disk Usage (Physical) ---" -ForegroundColor Yellow
# Write-Host "Ubuntu: $([math]::Round($uFile.Length / 1GB, 2)) GB" -ForegroundColor Cyan
# Write-Host "Docker: $([math]::Round($dFile.Length / 1GB, 2)) GB" -ForegroundColor Magenta
# Write-Host "----------------------------------"
