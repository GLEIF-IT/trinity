# Generates confs and data for witnesses

source lol.sh

if [[ "$1" != "--dev" && "$1" != "--staging" && "$1" != "--production" ]]; then
    echo "Invalid argument. Please provide --dev or --staging."
    exit 1
fi

env=${1#--}
conf="${env}/conf.yaml"

urls=()
saids=()

# genertate witness-oobis.json
for name in $(yq '.servers | keys | .[]' ${conf}); do
    url="$(yq ".servers.\"${name}\".ip" ${conf})/oobi?name=${name}"
    urls+=("\"$url\"")

    said=$(yq ".servers.\"$name\".said" ${conf})
    saids+=("$said")
done

wits=$(printf ",%s" "${urls[@]}")
wits="[${wits:1}]"

echo "Writing file: ${env}/conf/probe/keri/cf/witness-oobis.json $(lol)"
echo { \"dt\": \"2022-01-20T12:57:59.823350+00:00\", \"iurls\": ${wits}} | jq '.' > "${env}/conf/probe/keri/cf/witness-oobis.json"


# generate individual configs.json
i=0
for said in "${saids[@]}"; do
    let i++
    echo "Writing file: ${env}/data/probe/${said}.json $(lol)"
    echo { \"transferable\": true, \"wits\": \[ \"${said}\" \], \"toad\": 1, \"icount\": 1, \"ncount\": 1, \"isith\": \"1\", \"nsith\": \"1\" } | jq '.' > "${env}/data/probe/${said}.json"
done

wits=$(printf ",\"%s\"" "${saids[@]}")
wits="[${wits:1}]"

# generate group config
echo "Writing file: ${env}/data/probe/group.json $(lol)"
echo { \"transferable\": true, \"wits\": ${wits}, \"toad\": ${i}, \"icount\": 1, \"ncount\": 1, \"isith\": \"1\", \"nsith\": \"1\" } | jq '.' > "${env}/data/probe/group.json"
