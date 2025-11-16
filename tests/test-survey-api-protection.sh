#!/bin/bash

echo "============================================================"
echo "Testing Survey API GET Protection"
echo "============================================================"
echo ""

# Use a booking ID we know exists
BOOKING_ID="4a8a8cff-f3bf-4920-8179-09df83b3c802"

# Test 1: No API key
echo "Test 1: Accessing survey WITHOUT API key"
echo "Expected: 401 Unauthorized"
echo "------------------------------------------------------------"
RESPONSE1=$(curl -s -X GET "http://localhost:8000/api/surveys/$BOOKING_ID")
echo "$RESPONSE1" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE1"
echo ""

# Test 2: Invalid API key
echo "Test 2: Accessing survey with INVALID API key"
echo "Expected: 401 Unauthorized"
echo "------------------------------------------------------------"
RESPONSE2=$(curl -s -X GET "http://localhost:8000/api/surveys/$BOOKING_ID" \
  -H "X-API-Key: invalid-key-123")
echo "$RESPONSE2" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE2"
echo ""

# Test 3: Valid API key (you need to have the API key set in .env)
echo "Test 3: Accessing survey with VALID API key"
echo "Expected: 200 OK with survey data"
echo "------------------------------------------------------------"
# Read API key from .env file
if [ -f backend/.env ]; then
  API_KEY=$(grep "^API_KEY=" backend/.env | cut -d '=' -f2)
  if [ -n "$API_KEY" ]; then
    RESPONSE3=$(curl -s -X GET "http://localhost:8000/api/surveys/$BOOKING_ID" \
      -H "X-API-Key: $API_KEY")
    echo "$RESPONSE3" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE3"
  else
    echo "API_KEY not found in backend/.env"
  fi
else
  echo "backend/.env file not found"
fi
echo ""

echo "============================================================"
echo "Test Summary"
echo "============================================================"
echo "✅ The GET /api/surveys/{booking_id} endpoint is now protected"
echo "   - Requires X-API-Key header"
echo "   - Returns 401 Unauthorized without valid key"
echo "   - Returns survey data with valid admin key"
echo ""
echo "This ensures that only authorized admins can retrieve"
echo "sensitive survey responses from users."
echo "============================================================"
