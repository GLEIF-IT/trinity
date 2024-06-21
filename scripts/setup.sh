#!/bin/bash

lol() {
    local SEED=$(date +%s)
    local EMOJI_LIST=(🌟 ✨ 🌈 🎉 🎊 🎈 🏅 🏆 🌞 🌼 🌸 🌺 🍀 🍎 🍏 🍉 🍓 🍒 🍇 🍍 🥝 🥥 🍋 🍊 🍌 🍐 🍑 🍈 🥭 🥑 🥕 🥦 🥒 🌽 🌶 🫑 🥔 🥗 🥙 🥯 🥖 🥨 🍞 🥧 🍰 🎂 🍪 🍩 🍫 🍬 🍭 🍮 🍯)
    local EMOJI_COUNT=${#EMOJI_LIST[@]}

    RANDOM_INDEX=$((SEED % EMOJI_COUNT))
    echo "${EMOJI_LIST[$RANDOM_INDEX]}"
}

if ! [[ "$(uname)" == "Darwin" ]]; then
    exit 1
fi

if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew $(lol)"
fi

# Check if jq is installed
if ! brew list jq &>/dev/null; then
    echo "jq is not installed. Installing jq..."
    brew install jq
else
    echo "jq $(lol)"
fi

# Check if tree is installed
if ! brew list tree &>/dev/null; then
    echo "tree is not installed. Installing tree..."
    brew install tree
else
    echo "tree $(lol)"
fi

script=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export TRINITY_SCRIPT_DIR="${script}"