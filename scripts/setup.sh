#!/bin/bash

source lol.sh

if ! [[ "$(uname)" == "Darwin" ]]; then
    exit 1
fi

if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew $(lol)"
fi

if ! brew list jq &>/dev/null; then
    echo "jq is not installed. Installing jq..."
    brew install jq
else
    echo "jq $(lol)"
fi

if ! brew list yq &>/dev/null; then
    echo "yq is not installed. Installing yq..."
    brew install yq
else
    echo "yq $(lol)"
fi

if ! brew list tree &>/dev/null; then
    echo "tree is not installed. Installing tree..."
    brew install tree
else
    echo "tree $(lol)"
fi

script=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export TRINITY_SCRIPT_DIR="${script}"