#!/usr/bin/env bash
export CUDA_HOME=/usr/local/cuda
export MESA_D3D12_DEFAULT_ADAPTER_NAME=nvidia

[ -d "$CUDA_HOME/bin" ] && [ "${PATH#*$CUDA_HOME/bin:}" == "$PATH" ] && export PATH="$CUDA_HOME/bin:$PATH"
[ -d "$CUDA_HOME/lib64" ] && [ "${LD_LIBRARY_PATH#*$CUDA_HOME/lib64:}" == "$LD_LIBRARY_PATH" ] && export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
