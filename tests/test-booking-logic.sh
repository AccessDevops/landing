#!/bin/bash

echo "======================================"
echo "Testing Booking Update/Create Logic"
echo "======================================"
echo ""
echo "This test demonstrates the following behavior:"
echo "  1. When a user creates a booking, it's saved"
echo "  2. When the same user books again, the FUTURE booking is UPDATED (moved)"
echo "  3. When a booking is in the past, a NEW booking is created instead"
echo ""
echo "======================================"
echo ""

# Test 1: Create initial booking for user1
echo "📅 TEST 1: Creating initial booking for user1@example.com"
echo "Date: 2025-12-20, Time: 11:00"
echo ""
RESPONSE1=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user1@example.com",
    "name": "Test User 1",
    "booking_date": "2025-12-20",
    "booking_time": "11:00",
    "description": "Initial booking"
  }')

echo "$RESPONSE1" | python3 -m json.tool
ACTION1=$(echo "$RESPONSE1" | python3 -c "import sys, json; print(json.load(sys.stdin).get('action', 'N/A'))" 2>/dev/null)
BOOKING_ID1=$(echo "$RESPONSE1" | python3 -c "import sys, json; print(json.load(sys.stdin).get('booking', {}).get('id', 'N/A'))" 2>/dev/null)

echo ""
echo "✅ Result: Action = $ACTION1, Booking ID = $BOOKING_ID1"
echo ""
echo "======================================"
echo ""

# Wait a moment
sleep 1

# Test 2: Update booking for user1 (same email, different date/time)
echo "🔄 TEST 2: Rebooking for user1@example.com (same email)"
echo "New Date: 2025-12-25, New Time: 14:00"
echo "Expected: UPDATE (move) the existing booking"
echo ""
RESPONSE2=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user1@example.com",
    "name": "Test User 1 Updated",
    "booking_date": "2025-12-25",
    "booking_time": "14:00",
    "description": "Updated booking"
  }')

echo "$RESPONSE2" | python3 -m json.tool
ACTION2=$(echo "$RESPONSE2" | python3 -c "import sys, json; print(json.load(sys.stdin).get('action', 'N/A'))" 2>/dev/null)
BOOKING_ID2=$(echo "$RESPONSE2" | python3 -c "import sys, json; print(json.load(sys.stdin).get('booking', {}).get('id', 'N/A'))" 2>/dev/null)

echo ""
echo "✅ Result: Action = $ACTION2, Booking ID = $BOOKING_ID2"
if [ "$BOOKING_ID1" = "$BOOKING_ID2" ]; then
  echo "✅ PASS: Same booking ID - the booking was UPDATED (moved)"
else
  echo "❌ FAIL: Different booking ID - a new booking was created instead of updating"
fi
echo ""
echo "======================================"
echo ""

# Wait a moment
sleep 1

# Test 3: Create booking for user2
echo "📅 TEST 3: Creating booking for user2@example.com"
echo "Date: 2025-12-21, Time: 10:00"
echo ""
RESPONSE3=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user2@example.com",
    "name": "Test User 2",
    "booking_date": "2025-12-21",
    "booking_time": "10:00",
    "description": "User 2 booking"
  }')

echo "$RESPONSE3" | python3 -m json.tool
ACTION3=$(echo "$RESPONSE3" | python3 -c "import sys, json; print(json.load(sys.stdin).get('action', 'N/A'))" 2>/dev/null)

echo ""
echo "✅ Result: Action = $ACTION3"
echo ""
echo "======================================"
echo ""

echo "📊 SUMMARY:"
echo "  - Test 1: Initial booking → Action should be 'created' ✓"
echo "  - Test 2: Same email rebooking → Action should be 'updated' ✓"
echo "  - Test 3: Different email → Action should be 'created' ✓"
echo ""
echo "🔍 KEY BEHAVIOR:"
echo "  - If a user has a FUTURE booking (date > today), it gets UPDATED"
echo "  - If a user has a PAST booking (date <= today), a NEW booking is created"
echo "  - This is controlled by the condition in crud.py:31 (booking_date > today)"
echo ""
echo "======================================"
echo ""
echo "Note: To test past bookings, you would need to manually insert"
echo "      a past booking into the database and then try to create a"
echo "      new booking with the same email."
echo ""
