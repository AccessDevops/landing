#!/bin/bash

echo "============================================================"
echo "Complete Booking + Survey Flow Test"
echo "============================================================"
echo ""
echo "This test demonstrates the complete user journey:"
echo "  1. User creates a booking"
echo "  2. User submits a survey after booking"
echo "  3. Google Chat notifications are sent for both events"
echo ""
echo "============================================================"
echo ""

# Generate unique email for this test run
TIMESTAMP=$(date +%s)
TEST_EMAIL="complete-flow-${TIMESTAMP}@example.com"

# Step 1: Create a booking
echo "📅 STEP 1: Creating a booking"
echo "------------------------------------------------------------"
echo "Email: $TEST_EMAIL"
echo "Date: 2025-12-23"
echo "Time: 16:00"
echo ""

BOOKING_RESPONSE=$(curl -s -X POST http://localhost:8000/api/bookings/ \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"$TEST_EMAIL\",
    \"name\": \"Complete Flow Test User\",
    \"booking_date\": \"2025-12-23\",
    \"booking_time\": \"16:00\",
    \"description\": \"Testing complete booking and survey flow\"
  }")

echo "Booking Response:"
echo "$BOOKING_RESPONSE" | python3 -m json.tool
echo ""

# Extract booking ID
BOOKING_ID=$(echo "$BOOKING_RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('booking', {}).get('id', ''))" 2>/dev/null)

if [ -z "$BOOKING_ID" ]; then
  echo "❌ Failed to create booking"
  exit 1
fi

echo "✅ Booking created successfully!"
echo "   Booking ID: $BOOKING_ID"
echo "   📧 Check Google Chat for booking notification"
echo ""

# Wait a moment
echo "⏳ Waiting 2 seconds before submitting survey..."
sleep 2
echo ""

# Step 2: Submit survey
echo "📋 STEP 2: Submitting survey"
echo "------------------------------------------------------------"
echo "Booking ID: $BOOKING_ID"
echo ""

SURVEY_RESPONSE=$(curl -s -X POST http://localhost:8000/api/surveys \
  -H "Content-Type: application/json" \
  -d "{
    \"booking_id\": \"$BOOKING_ID\",
    \"role\": [\"CTO\", \"DevOps Engineer\"],
    \"cloud_usage\": [\"AWS\", \"Microsoft Azure\", \"Google Cloud\"],
    \"development_approach\": [\"Agile/Scrum\", \"DevOps/GitOps\"],
    \"team_size\": [\"13–25\"],
    \"primary_goals\": [
      \"Accelerate software delivery / CI/CD\",
      \"Improve infrastructure reliability & uptime\",
      \"Reduce cloud infrastructure costs\"
    ],
    \"other_goal\": \"Implement advanced monitoring and observability\"
  }")

echo "Survey Response:"
echo "$SURVEY_RESPONSE" | python3 -m json.tool
echo ""

# Extract survey ID
SURVEY_ID=$(echo "$SURVEY_RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('id', ''))" 2>/dev/null)

if [ -z "$SURVEY_ID" ]; then
  echo "❌ Failed to submit survey"
  exit 1
fi

echo "✅ Survey submitted successfully!"
echo "   Survey ID: $SURVEY_ID"
echo "   📧 Check Google Chat for survey notification"
echo ""

# Summary
echo "============================================================"
echo "📊 TEST SUMMARY"
echo "============================================================"
echo "✅ Booking created: $BOOKING_ID"
echo "✅ Survey submitted: $SURVEY_ID"
echo ""
echo "📧 Google Chat Notifications:"
echo "   1. Booking notification (with booking details)"
echo "   2. Survey notification (with booking + survey details)"
echo ""
echo "💡 The survey notification includes:"
echo "   - Booking information (name, email, date, time)"
echo "   - Survey responses (role, cloud usage, approach, etc.)"
echo "   - Formatted as a Google Chat card for easy reading"
echo ""
echo "============================================================"
echo ""
echo "✅ Test completed successfully!"
echo "   Check your Google Chat space for 2 notifications:"
echo "   • 'DevOps Audit' notification (booking)"
echo "   • 'Survey Completed' notification (survey)"
echo ""
