#!/usr/bin/env bash
backupAndTurnOff() {
  local _currentSecond="$(date +%s)"
  echo "Starting to backup firewall."
  echo "============================"
  echo
  #The following sudo is to get started. If I started on next command, password
  #would be prompted twice because of the pipe. The following sudos don't prompt.
  sudo echo
  sudo iptables-save | sudo tee -a "/root/firewall-${_currentSecond}-backup.rules"
  sudo iptables -X
  sudo iptables -t nat -F
  sudo iptables -t nat -X
  sudo iptables -t mangle -F
  sudo iptables -t mangle -X
  sudo iptables -P INPUT ACCEPT
  sudo iptables -P FORWARD ACCEPT
  sudo iptables -P OUTPUT ACCEPT
  echo
  echo "To restore firewall rules: \"iptables-restore < /root/firewall-${_currentSecond}-backup.rules\""
}

backupAndTurnOff
