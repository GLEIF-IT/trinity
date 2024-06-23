#!/bin/bash

if [[ "$1" != "--dev" && "$1" != "--staging" && "$1" != "--production" ]]; then
    echo "Invalid argument. Please provide --dev or --staging."
    exit 1
fi

env=${1#--}
conf="${TRINITY_SCRIPT_DIR}/${env}/conf/probe"
data="${TRINITY_SCRIPT_DIR}/${env}/data/probe"

echo "Using Configuration:"
echo -e "env\t${env}"
echo -e "data\t${data}"
echo -e "conf\t${conf}"

tree "${conf}"
tree "${data}"

kli init --name probe --nopasscode --config-dir "${conf}" --config-file witness-oobis
kli incept --name probe --alias probe --file ${data}/group.json

ws=()
while IFS= read -r value; do
  ws+=("$(echo "$value" | tr -d '[]",')")
done <<<"$(jq -r '.wits[]' ${data}/group.json)"

r=0
for w in "${ws[@]}"; do
  proobi="$(kli oobi generate --name probe --alias probe --role witness | sed -n '1 p')"
  kli ends add --name probe --alias probe --eid "$w" --role mailbox
  echo -e "\n"

  let r++
  echo "init/incept r${r}"

  kli init --name "r${r}" --nopasscode --config-dir "${conf}" --config-file witness-oobis
  kli incept --name "r${r}" --alias "r${r}" --file ${data}/$w.json
  kli ends add --name "r${r}" --alias "r${r}" --eid ${w} --role mailbox

  echo -e "\n"

  roobi="$(kli oobi generate --name "r${r}" --alias "r${r}" --role witness | sed -n '1 p')"
  kli oobi resolve --name probe --oobi-alias "r${r}" --oobi "${roobi}"
  kli oobi resolve --name "r${r}" --oobi-alias probe --oobi "${proobi}"

  words="$(kli challenge generate --out string)"

  echo "Challenging r${r} with ${words}"
  export KLI_DEBUG=1
  kli challenge respond --name probe --alias probe --recipient "r${r}" --words "${words}"
  kli challenge verify --name "r${r}" --alias "r${r}" --signer probe --words "${words}"
done
