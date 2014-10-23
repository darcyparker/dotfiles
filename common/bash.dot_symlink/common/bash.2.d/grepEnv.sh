#!/usr/bin/env bash
#Note because of spaces, $GREP_OPTIONS must be wrapped in quotes
if [ -z "$GREP_OPTIONS" ]; then
  export GREP_OPTIONS="--binary-files=without-match --color=auto --exclude=tags --exclude=TAGS --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.hg"
fi
