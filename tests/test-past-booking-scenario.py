#!/usr/bin/env python3
"""
Test script to verify past booking behavior.

This script:
1. Manually inserts a past booking into the database
2. Attempts to create a new booking with the same email
3. Verifies that a NEW booking is created (not updated)
"""

import sqlite3
from datetime import datetime, timedelta, date
import uuid
import requests

# Database path
DB_PATH = "backend/bookings.db"
API_URL = "http://localhost:8000"

def insert_past_booking(email: str, name: str) -> str:
    """Insert a past booking directly into the database."""
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    booking_id = str(uuid.uuid4())
    past_date = (date.today() - timedelta(days=5)).isoformat()  # 5 days ago
    booking_time = "10:00:00"
    created_at = datetime.utcnow().isoformat()

    cursor.execute("""
        INSERT INTO bookings (id, email, name, booking_date, booking_time, description, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        booking_id,
        email,
        name,
        past_date,
        booking_time,
        "Past booking inserted directly",
        created_at,
        created_at
    ))

    conn.commit()
    conn.close()

    print(f"✅ Inserted past booking:")
    print(f"   ID: {booking_id}")
    print(f"   Email: {email}")
    print(f"   Date: {past_date} (PAST)")
    print(f"   Time: {booking_time}")

    return booking_id

def create_booking_via_api(email: str, name: str, booking_date: str, booking_time: str):
    """Create a booking via the API."""
    response = requests.post(
        f"{API_URL}/api/bookings/",
        json={
            "email": email,
            "name": name,
            "booking_date": booking_date,
            "booking_time": booking_time,
            "description": "New booking via API"
        }
    )
    return response.json()

def main():
    print("=" * 60)
    print("Testing Past Booking Scenario")
    print("=" * 60)
    print()

    # Test email
    test_email = "past-booking-test@example.com"

    # Step 1: Insert a past booking
    print("📌 STEP 1: Insert a past booking into database")
    print("-" * 60)
    past_booking_id = insert_past_booking(test_email, "Past Booking User")
    print()

    # Step 2: Attempt to create a new booking with same email
    print("📌 STEP 2: Create a new booking via API (same email)")
    print("-" * 60)
    future_date = (date.today() + timedelta(days=10)).isoformat()
    future_time = "14:00"

    print(f"Creating booking for:")
    print(f"   Email: {test_email}")
    print(f"   Date: {future_date} (FUTURE)")
    print(f"   Time: {future_time}")
    print()

    result = create_booking_via_api(test_email, "New Booking User", future_date, future_time)

    print("API Response:")
    import json
    print(json.dumps(result, indent=2))
    print()

    # Step 3: Verify the behavior
    print("=" * 60)
    print("📊 VERIFICATION")
    print("=" * 60)

    action = result.get('action')
    new_booking_id = result.get('booking', {}).get('id')

    print(f"Action: {action}")
    print(f"Past Booking ID: {past_booking_id}")
    print(f"New Booking ID:  {new_booking_id}")
    print()

    if action == "created" and past_booking_id != new_booking_id:
        print("✅ PASS: A NEW booking was created (past booking was NOT updated)")
        print("   This is the expected behavior!")
    elif action == "updated" and past_booking_id == new_booking_id:
        print("❌ FAIL: The past booking was updated (should have created new)")
    else:
        print(f"⚠️  UNEXPECTED: Action={action}, IDs match={past_booking_id == new_booking_id}")

    print()
    print("=" * 60)
    print("💡 Explanation:")
    print("   The crud.py function `get_booking_by_email_future()` filters")
    print("   bookings with: booking_date > today")
    print("   ")
    print("   Since the past booking has booking_date <= today, it is NOT")
    print("   found, and a NEW booking is created instead of updating.")
    print("=" * 60)

if __name__ == "__main__":
    main()
