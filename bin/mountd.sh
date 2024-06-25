#!/usr/bin/env bash
sudo mount -t drvfs d: /mnt/d -o uid=$(id -u $USER),gid=$(id -g $USER),metadata
