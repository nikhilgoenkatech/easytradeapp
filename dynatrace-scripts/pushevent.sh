#!/bin/bash -x

# Bash Script that will push a Custom Annotation event to Dynatrace via ${DT_URL}/api/v1/events
# The script also assumes the ${DT_TOKEN} contains your API-Token!
# Either set your Dynatrace Token and URL in this script or pass it as Env Variables to this Shell Script
# DT_TOKEN=YOURAPITOKEN
# DT_URL=https://YOURTENANT.live.dynatrace.com
# When used with Jenkins we suggest to define DT_TOKEN and DT_URL as Global Environment Variables - they will then get passed to your shell script automatically

# Usage:
# ./pushevent.sh ENTITYTYPE TAGCONTEXT TAGNAME TAGVALUE ANNOTATIONTYPE SOURCE ANNOTATIONDESCRIPTION CILINK JENKINSURL BUILDURL GITCOMMIT

# Example from command line:
# Pushing a Custom Deployment Event to a HOST with the tag [AWS]Environment:JenkinsTutorial
# ./pushevent.sh HOST AWS Environment JenkinsTutorial "Start Load Test" "Jenkins Job XYZ" "My description about this event" http://myjenkins http://myjenkins/job http://myjenins/build gitcommitid

# Example from Jenkins:
# Pushing same Custom Deployment event using Jenkins Propeties


PAYLOAD=$(cat <<EOF
{  "eventType": "CUSTOM_ANNOTATION",
  "entitySelector": "type($1), tag($2:$3,$4:$5)",
  "title":"\"$6\"",
  "properties" : {
  "JenkinsJobName" : "$7",
  "BuildUrl" : "$9",
  "Description": "$8",
  "BuildVersion":"${12}",
  "SRGTimestamp":"$(date --utc +%FT%T.000000000Z)",
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

