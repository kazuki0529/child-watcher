#!/bin/bash

set -eux

export DEBIAN_FRONTEND=noninteractive
sudo apt update && sudo apt upgrade \
  && sudo apt -y install --no-install-recommends \
    python3-pip build-essential libffi-dev libssl-dev zlib1g-dev \
    liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev libopencv-dev tk-dev git

declare -r PYTHON_VERSION=3.9.7

# pyenvのインストール
[[ ! -e ~/.pyenv ]] \
  && git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
  && echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.bashrc \
  && echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' >> ~/.bashrc \
  && echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc

$HOME/.pyenv/bin/pyenv install ${PYTHON_VERSION} -s

pip install pipenv && pipenv install
