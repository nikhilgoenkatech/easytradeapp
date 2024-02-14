PAYLOAD=$(cat <<EOF
{  "eventType": "CUSTOM_ANNOTATION",
  "entitySelector": "type($1), tag($2:$3,$4:$5)",
  "title":"\"$6\"",
  "properties" : {
  "JenkinsJobName" : "$7",
  "BuildUrl" : "$9",
  "Description": "$8",
  "BuildVersion":"${12}",
  "StartTimestamp":"${13}",
  "EndTimestamp":"$(date --utc +%FT%T.000000000Z)",
  "owner": "easytrade-frontend"
  }
}
EOF
)
echo $PAYLOAD

curl -X 'POST' \
     "${DT_URL}/api/v2/events/ingest/" \
     -H "accept: application/json; charset=utf-8" \
     -H "Content-Type: application/json; charset=utf-8" \
     -H "Authorization: Api-Token ${DT_TOKEN}" \
     -d "${PAYLOAD}"
