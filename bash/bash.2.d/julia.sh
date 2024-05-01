#!/usr/bin/env bash
case ":$PATH:" in
  *:/home/darcy/.juliaup/bin:*)
    ;;

  *)
    export PATH=/home/darcy/.juliaup/bin${PATH:+:${PATH}}
    ;;
esac
