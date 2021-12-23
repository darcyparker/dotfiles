#!/usr/bin/env bash
if [ -z "$_freeCADEnv" ]; then
  export _freeCADEnv=1
  export PYTHONPATH=/usr/local/opt/freecad/bin:$PYTHONPATH
fi
