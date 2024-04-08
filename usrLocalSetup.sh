#!/usr/bin/env bash
# Modern wisdom says to open up access to `/usr/local` You shouldn't have to be
# a sudoer to install software to `/usr/local`.
# ie: This is a bad practice: `sudo npm install -g` etc...
echo "================================"
echo "Setup permissions for /usr/local"
echo "================================"
sudo chown -R "$USER":users /usr/local
sudo find /usr/local -type d -exec chmod "u=rwx,g=rwx,o=rx" {} \;
sudo find /usr/local/bin -type f -exec chmod "u=rwx,g=rwx,o=rx" {} \;
sudo find /usr/local/bin -type l -exec chmod "u=rwx,g=rwx,o=rx" {} \;
