#!/bin/bash

echo "=== Testing Survey Flow ==="
echo ""

# Step 1: Create a booking
echo "1. Creating a new booking..."
BOOKING_RESPONSE=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "flow-test@example.com",
    "name": "Flow Test User",
    "booking_date": "2025-12-21",
    "booking_time": "11:00",
    "description": "Testing the complete survey flow"
  }')

echo "$BOOKING_RESPONSE" | python3 -m json.tool

# Extract booking ID
BOOKING_ID=$(echo "$BOOKING_RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin)['booking']['id'])" 2>/dev/null)

if [ -z "$BOOKING_ID" ]; then
  echo "Failed to create booking or extract ID"
  exit 1
fi

echo ""
echo "✓ Booking created with ID: $BOOKING_ID"
echo ""

# Step 2: Submit survey
echo "2. Submitting survey for booking..."
SURVEY_RESPONSE=$(curl -s -X POST http://localhost:8000/api/surveys \
  -H "Content-Type: application/json" \
  -d "{
    \"booking_id\": \"$BOOKING_ID\",
    \"role\": [\"CTO\", \"DevOps\"],
    \"cloud_usage\": [\"AWS\", \"Microsoft Azure\"],
    \"development_approach\": [\"Hybrid\"],
    \"team_size\": [\"6–12\"],
    \"primary_goals\": [\"Accelerate software delivery / CI/CD\", \"Improve infrastructure reliability & uptime\"],
    \"other_goal\": null
  }")

echo "$SURVEY_RESPONSE" | python3 -m json.tool

echo ""
echo "✓ Survey submitted successfully"
echo ""
echo "=== Test Complete ==="
echo ""
echo "Summary:"
echo "  - Booking ID: $BOOKING_ID"
echo "  - Survey ID: $(echo "$SURVEY_RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('id', 'N/A'))" 2>/dev/null)"
echo ""
echo "Check your Google Chat for the webhook notification!"
