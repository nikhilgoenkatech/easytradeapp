#!/bin/bash

PAYLOAD=$(cat <<EOF
{
  "name": "$1 $2-$3",
  "frequencyMin": 5,
  "enabled": true,
  "type": "BROWSER",
  "createdFrom": "GUI",
  "script": {
    "type": "clickpath",
    "version": "1.0",
    "configuration": {
      "device": {
        "deviceName": "Desktop",
        "orientation": "landscape"
      },
      "chromiumStartupFlags": {
        "disable-web-security": false
      }
    },
    "events": [
      {
        "type": "navigate",
        "description": "Loading of \"http://${PUBLIC_IP}:$4\"",
        "url": "http://${PUBLIC_IP}:$4",
        "wait": {
          "waitFor": "page_complete"
        }
      },
      {
        "type": "click",
        "description": "click",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "button[type=\"submit\"]:eq(1)"
            },
            {
              "type": "css",
              "value": "button:contains(\"Log in as\")"
            },
            {
              "type": "css",
              "value": ".MuiButtonBase-root:eq(4)"
            },
            {
              "type": "css",
              "value": "#root div div:nth-child(2) div div div div:nth-child(3) form div:nth-child(2) div button"
            },
            {
              "type": "css",
              "value": "#root div.MuiStack-root div.MuiBox-root div.MuiPaper-root div.MuiCardContent-root div.MuiStack-root div.MuiGrid2-root form div.MuiGrid2-root div.MuiCardActions-root button.MuiButtonBase-root:eq(1)"
            }
          ]
        },
        "button": 0,
        "wait": {
          "waitFor": "network"
        }
      },
      {
        "type": "click",
        "description": "click on \"Instruments\"",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "a:contains(\"Instruments\")"
            },
            {
              "type": "css",
              "value": "span:contains(\"Instruments\")"
            },
            {
              "type": "css",
              "value": ".MuiTypography-root:eq(3)"
            },
            {
              "type": "css",
              "value": "#root div div:nth-child(2) div div div:nth-child(2) ul li:nth-child(2) a div:nth-child(2) span"
            },
            {
              "type": "css",
              "value": "#root div.MuiStack-root div.MuiBox-root div.MuiDrawer-root div.MuiPaper-root div.MuiBox-root ul.MuiList-root li.MuiListItem-root a.MuiButtonBase-root div.MuiListItemText-root span.MuiTypography-root:eq(1)"
            }
          ]
        },
        "button": 0
      },
      {
        "type": "click",
        "description": "click on \"Credit Card\"",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "a:contains(\"Credit Card\")"
            },
            {
              "type": "css",
              "value": "span:contains(\"Credit Card\")"
            },
            {
              "type": "css",
              "value": ".MuiTypography-root:eq(6)"
            },
            {
              "type": "css",
              "value": "#root div div:nth-child(2) div div div:nth-child(2) ul li:nth-child(5) a div:nth-child(2) span"
            },
            {
              "type": "css",
              "value": "#root div.MuiStack-root div.MuiBox-root div.MuiDrawer-root div.MuiPaper-root div.MuiBox-root ul.MuiList-root li.MuiListItem-root a.MuiButtonBase-root div.MuiListItemText-root span.MuiTypography-root:eq(4)"
            }
          ]
        },
        "button": 0,
        "wait": {
          "waitFor": "network"
        }
      },
      {
        "type": "click",
        "description": "click on \"Autofill\"",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "button[type=\"button\"]:eq(4)"
            },
            {
              "type": "css",
              "value": "button:contains(\"Autofill\")"
            },
            {
              "type": "css",
              "value": ".MuiButtonBase-root:eq(12)"
            },
            {
              "type": "css",
              "value": "#root div div:nth-child(2) div:nth-child(2) div div div div div:nth-child(2) form div:nth-child(7) div button:nth-child(2)"
            },
            {
              "type": "css",
              "value": "#root div.MuiStack-root div.MuiBox-root div.MuiGrid2-root div.MuiBox-root div.MuiPaper-root div.MuiCardContent-root div.MuiStack-root div.MuiGrid2-root form div.MuiGrid2-root div.MuiCardActions-root button.MuiButtonBase-root:eq(1)"
            }
          ]
        },
        "button": 0
      },
      {
        "type": "click",
        "description": "click on \"submitButton\"",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "#submitButton"
            },
            {
              "type": "css",
              "value": "button[type=\"submit\"]"
            },
            {
              "type": "css",
              "value": "button:contains(\"Order card\")"
            },
            {
              "type": "css",
              "value": ".MuiButtonBase-root:eq(11)"
            },
            {
              "type": "css",
              "value": "#root div div:nth-child(2) div:nth-child(2) div div div div div:nth-child(2) form div:nth-child(7) div button"
            },
            {
              "type": "css",
              "value": "#submitButton"
            }
          ]
        },
        "button": 0,
        "wait": {
          "waitFor": "network"
        }
      },
      {
        "type": "click",
        "description": "click on \"Home\"",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "a:contains(\"Home\")"
            },
            {
              "type": "css",
              "value": "span:contains(\"Home\")"
            },
            {
              "type": "css",
              "value": ".MuiTypography-root:eq(2)"
            },
            {
              "type": "css",
              "value": "#root div div:nth-child(2) div div div:nth-child(2) ul li a div:nth-child(2) span"
            },
            {
              "type": "css",
              "value": "#root div.MuiStack-root div.MuiBox-root div.MuiDrawer-root div.MuiPaper-root div.MuiBox-root ul.MuiList-root li.MuiListItem-root a.MuiButtonBase-root div.MuiListItemText-root span.MuiTypography-root:eq(0)"
            }
          ]
        },
        "button": 0
      },
      {
        "type": "click",
        "description": "click on \"J\"",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "div:contains(\"J\"):eq(5)"
            },
            {
              "type": "css",
              "value": ".MuiAvatar-root"
            },
            {
              "type": "css",
              "value": "#profileToggler div"
            },
            {
              "type": "css",
              "value": "#profileToggler div.MuiAvatar-root"
            }
          ]
        },
        "button": 0
      },
      {
        "type": "click",
        "description": "click on \"logoutItem\"",
        "target": {
          "locators": [
            {
              "type": "css",
              "value": "#logoutItem"
            },
            {
              "type": "css",
              "value": ".MuiButtonBase-root:eq(42)"
            },
            {
              "type": "css",
              "value": "html body:nth-child(2) div:nth-child(4) div:nth-child(3) ul li"
            },
            {
              "type": "css",
              "value": "#logoutItem"
            }
          ]
        },
        "button": 0,
        "wait": {
          "waitFor": "network"
        }
      }
    ]
  },
  "locations": [
    "GEOLOCATION-57F63BAD1C6A415C"
  ],
  "anomalyDetection": {
    "outageHandling": {
      "globalOutage": true,
      "globalOutagePolicy": {
        "consecutiveRuns": 1
      },
      "localOutage": false,
      "localOutagePolicy": {
        "affectedLocations": null,
        "consecutiveRuns": null
      },
      "retryOnError": true
    },
    "loadingTimeThresholds": {
      "enabled": true,
      "thresholds": []
    }
  },
  "tags": [],
  "managementZones": [],
  "automaticallyAssignedApps": [
    "APPLICATION-827F4150B32AC679"
  ],
  "manuallyAssignedApps": [],
  "keyPerformanceMetrics": {
    "loadActionKpm": "VISUALLY_COMPLETE",
    "xhrActionKpm": "VISUALLY_COMPLETE"
  },
  "events": [
    {
      "name": "Loading of \"http://${PUBLIC_IP}\"",
      "sequenceNumber": 1
    },
    {
      "name": "click",
      "sequenceNumber": 2
    },
    {
      "name": "click on \"Instruments\"",
      "sequenceNumber": 3
    },
    {
      "name": "click on \"Credit Card\"",
      "sequenceNumber": 4
    },
    {
      "name": "click on \"Autofill\"",
      "sequenceNumber": 5
    },
    {
      "name": "click on \"submitButton\"",
      "sequenceNumber": 6
    },
    {
      "name": "click on \"Home\"",
      "sequenceNumber": 7
    },
    {
      "name": "click on \"J\"",
      "sequenceNumber": 8
    },
    {
      "name": "click on \"logoutItem\"",
      "sequenceNumber": 9
    }
  ]
}
EOF
)
echo $PAYLOAD
curl -H "Content-Type: application/json" -H "Authorization: Api-Token ${DT_TOKEN}" -X POST -d "${PAYLOAD}" ${DT_URL}/api/v1/synthetic/monitors
