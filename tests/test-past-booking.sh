#!/bin/bash

echo "=== Testing Past Booking Logic ==="
echo ""

# Step 1: Create a booking in the past (this should fail due to "no today bookings" rule)
echo "1. Attempting to create a past booking (should fail)..."
PAST_RESPONSE=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "past-test@example.com",
    "name": "Past Test User",
    "booking_date": "2024-12-01",
    "booking_time": "11:00",
    "description": "Testing past booking logic"
  }')

echo "$PAST_RESPONSE" | python3 -m json.tool
echo ""

# Step 2: Create a future booking
echo "2. Creating a future booking..."
FUTURE_RESPONSE=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "future-test@example.com",
    "name": "Future Test User",
    "booking_date": "2025-12-25",
    "booking_time": "14:00",
    "description": "Testing future booking logic"
  }')

echo "$FUTURE_RESPONSE" | python3 -m json.tool
echo ""

# Step 3: Update the future booking (should update, not create new)
echo "3. Updating the future booking to a different time..."
UPDATE_RESPONSE=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "future-test@example.com",
    "name": "Future Test User Updated",
    "booking_date": "2025-12-26",
    "booking_time": "15:00",
    "description": "Updated booking"
  }')

echo "$UPDATE_RESPONSE" | python3 -m json.tool
echo ""

echo "=== Test Complete ==="
echo ""
echo "Summary:"
echo "  - Past bookings should fail (today not allowed)"
echo "  - Future bookings should be created"
echo "  - Subsequent bookings with same email should UPDATE the future booking"
echo "  - If a booking was in the past, a new one would be created (but we can't test this without modifying DB)"
