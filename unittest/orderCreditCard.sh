#!/bin/bash

echo "Deleting existing credit card for account -> "
# Delete any existing credit card for account
delete_response=$(curl -X 'DELETE' \
    "http://$1/credit-card-order-service/v1/orders/3" \
    -H 'accept: application/json')

  if [ $? -eq 0 ]; then
    echo "Order deleted successfully."
  else
    echo "Error: Failed to delete order."
  fi

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
  "http://$1/credit-card-order-service/v1/orders" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d "$body")

echo "Card ordered, response: [$response]"
