#!/bin/bash

lol() {
    local SEED=$(date +%s)
    local EMOJI_LIST=(🌟 ✨ 🌈 🎉 🎊 🎈 🏅 🏆 🌞 🌼 🌸 🌺 🍀 🍎 🍏 🍉 🍓 🍒 🍇 🍍 🥝 🥥 🍋 🍊 🍌 🍐 🍑 🍈 🥭 🥑 🥕 🥦 🥒 🌽 🌶 🫑 🥔 🥗 🥙 🥯 🥖 🥨 🍞 🥧 🍰 🎂 🍪 🍩 🍫 🍬 🍭 🍮 🍯)
    local EMOJI_COUNT=${#EMOJI_LIST[@]}

    RANDOM_INDEX=$((SEED % EMOJI_COUNT))
    echo "${EMOJI_LIST[$RANDOM_INDEX]}"
}