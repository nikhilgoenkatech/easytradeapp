#!/bin/bash

echo "Checking latest credit card order status"

response=$(curl -X 'GET' \
  'http://$1/credit-card-order-service/v1/orders/3/status/latest' \
  -H 'accept: application/json')

echo "Response: [$response]"

status=$(echo "$response" | jq -r '.results.status')
echo "Latest card status: [$status]"

if [ "$status" == "card_delivered" ]; then
  exit 0
else
  exit 1
fi
