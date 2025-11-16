#!/bin/bash

echo "============================================================"
echo "Testing Past Booking Scenario"
echo "============================================================"
echo ""
echo "This test demonstrates that when a booking is in the PAST,"
echo "a NEW booking is created instead of updating the old one."
echo ""
echo "============================================================"
echo ""

# Variables
DB_PATH="backend/bookings.db"
TEST_EMAIL="past-booking-test@example.com"
PAST_DATE=$(date -v-5d +%Y-%m-%d 2>/dev/null || date -d '5 days ago' +%Y-%m-%d)
FUTURE_DATE=$(date -v+10d +%Y-%m-%d 2>/dev/null || date -d '10 days from now' +%Y-%m-%d)
BOOKING_ID=$(uuidgen | tr '[:upper:]' '[:lower:]')

echo "📌 STEP 1: Insert a past booking into database"
echo "------------------------------------------------------------"
echo "Email: $TEST_EMAIL"
echo "Date: $PAST_DATE (PAST)"
echo "Time: 10:00"
echo "Booking ID: $BOOKING_ID"
echo ""

# Insert past booking directly into SQLite database
sqlite3 "$DB_PATH" <<EOF
INSERT INTO bookings (id, email, name, booking_date, booking_time, description, created_at, updated_at)
VALUES (
  '$BOOKING_ID',
  '$TEST_EMAIL',
  'Past Booking User',
  '$PAST_DATE',
  '10:00:00',
  'Past booking inserted directly',
  datetime('now'),
  datetime('now')
);
EOF

echo "✅ Past booking inserted successfully"
echo ""

echo "📌 STEP 2: Create a new booking via API (same email)"
echo "------------------------------------------------------------"
echo "Email: $TEST_EMAIL (same as past booking)"
echo "Date: $FUTURE_DATE (FUTURE)"
echo "Time: 14:00"
echo ""

# Create new booking via API
RESPONSE=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"$TEST_EMAIL\",
    \"name\": \"New Booking User\",
    \"booking_date\": \"$FUTURE_DATE\",
    \"booking_time\": \"14:00\",
    \"description\": \"New booking via API\"
  }")

echo "API Response:"
echo "$RESPONSE" | python3 -m json.tool
echo ""

# Extract values
ACTION=$(echo "$RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('action', 'N/A'))" 2>/dev/null)
NEW_BOOKING_ID=$(echo "$RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('booking', {}).get('id', 'N/A'))" 2>/dev/null)

echo "============================================================"
echo "📊 VERIFICATION"
echo "============================================================"
echo "Action:           $ACTION"
echo "Past Booking ID:  $BOOKING_ID"
echo "New Booking ID:   $NEW_BOOKING_ID"
echo ""

if [ "$ACTION" = "created" ] && [ "$BOOKING_ID" != "$NEW_BOOKING_ID" ]; then
  echo "✅ PASS: A NEW booking was created (past booking was NOT updated)"
  echo "   This is the expected behavior!"
elif [ "$ACTION" = "updated" ] && [ "$BOOKING_ID" = "$NEW_BOOKING_ID" ]; then
  echo "❌ FAIL: The past booking was updated (should have created new)"
else
  echo "⚠️  UNEXPECTED: Action=$ACTION, IDs match=$([ "$BOOKING_ID" = "$NEW_BOOKING_ID" ] && echo 'true' || echo 'false')"
fi

echo ""
echo "============================================================"
echo "💡 Explanation:"
echo "   The crud.py function 'get_booking_by_email_future()' filters"
echo "   bookings with: booking_date > today"
echo "   "
echo "   Since the past booking has booking_date <= today, it is NOT"
echo "   found, and a NEW booking is created instead of updating."
echo "============================================================"
echo ""

# Verify by checking database
echo "🔍 Database verification:"
echo "------------------------------------------------------------"
echo "Bookings for $TEST_EMAIL in database:"
sqlite3 "$DB_PATH" <<EOF
SELECT
  id,
  booking_date,
  booking_time,
  CASE
    WHEN date(booking_date) <= date('now') THEN '(PAST/TODAY)'
    ELSE '(FUTURE)'
  END as status
FROM bookings
WHERE email = '$TEST_EMAIL'
ORDER BY booking_date;
EOF
echo ""
echo "If you see 2 bookings, the logic is working correctly!"
echo "============================================================"
