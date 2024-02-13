#!/bin/bash

body=$(cat <<EOF
{
  "accountId": 3,
  "email": "demo.user@dynatrace.com",
  "name": "Demo User",
  "shippingAddress": "ulica Andersa 352 91-682 Ilaw",
  "cardLevel": "Platinum"
}
EOF
)

echo "Ordering credit card with body: [$body]"

response=$(curl -X 'POST' \
  'https://easytrade.staging.demoability.dynatracelabs.com/credit-card-order-service/v1/orders' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d "$body")

echo "Card ordered, response: [$response]"
