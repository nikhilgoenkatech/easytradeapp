#!/bin/bash

echo "Checking latest credit card order status"

response=$(curl -X 'GET' \
  "http://$1/credit-card-order-service/v1/orders/3/status/latest" \
  -H 'accept: application/json')

echo "Response: [$response]"


status=$(echo "$response" | grep -o '"status": *"[^"]*"' | awk -F'"' '{print $4}')
echo "Latest card status: [$status]"

if [ "$status" == "card_delivered" ]; then
  echo "Status -> [$status]. Returning 0"
  exit 0
else
  echo "Status -> [$status]. Returning 1"
  exit 1
fi
