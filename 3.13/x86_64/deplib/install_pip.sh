#!/bin/sh

export PYTHON_PIP_VERSION=23.2.1
export PYTHON_SETUPTOOLS_VERSION=65.5.1
export PYTHON_GET_PIP_URL=https://bootstrap.pypa.io/get-pip.py
export PYTHON_PATH=/opt/python/bin/python3

curl -sSL "$PYTHON_GET_PIP_URL"-o get-pip.py
export PYTHONDONTWRITEBYTECODE=1

export LD_LIBRARY_PATH="/opt/python/lib:$LD_LIBRARY_PATH"
$PYTHON_PATH get-pip.py --disable-pip-version-check --no-cache-dir "setuptools==$PYTHON_SETUPTOOLS_VERSION"
rm -f get-pip.py
export PIP_PATH=/opt/python/bin/pip3
$PIP_PATH --version # buildkit
