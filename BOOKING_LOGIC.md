# Booking Logic Documentation

## Overview

This document explains the booking creation/update logic implemented in the backend API.

## Business Rules

When a user creates a booking with an email address:

1. **First-time booking**: A new booking is created
2. **Rebooking with same email (future booking exists)**: The existing FUTURE booking is UPDATED (moved to new date/time)
3. **Rebooking with same email (only past bookings exist)**: A NEW booking is created

## Implementation Details

### Key Code Locations

1. **[backend/app/crud.py:17-35](backend/app/crud.py#L17-L35)** - `get_booking_by_email_future()`
   - Filters bookings with `booking_date > today` (strictly future, excluding today)
   - Only returns future bookings
   - Returns `None` if no future booking exists (including when only past bookings exist)

2. **[backend/app/routers/bookings.py:20-114](backend/app/routers/bookings.py#L20-L114)** - `create_or_update_booking()`
   - Checks for existing future booking using `get_booking_by_email_future()`
   - If found → **UPDATE** the existing booking
   - If not found → **CREATE** a new booking

### Logic Flow

```
User creates booking with email X
    │
    ├─→ Check: Does email X have a booking where booking_date > today?
    │
    ├─→ YES (future booking exists)
    │   └─→ UPDATE that booking to new date/time
    │       └─→ Return: action = "updated", same booking ID
    │
    └─→ NO (no future booking)
        └─→ CREATE new booking
            └─→ Return: action = "created", new booking ID
```

## Why `booking_date > today` instead of `>= today`?

- The API rejects bookings for "today" ([bookings.py:36-41](backend/app/routers/bookings.py#L36-L41))
- Using `> today` means bookings for today are treated as "past" for update purposes
- This ensures consistency: if you can't CREATE a booking for today, you also can't UPDATE to a booking for today

## Test Results

### Test 1: Future Booking Update
```bash
# Create booking for 2025-12-20
→ Action: "created", ID: abc-123

# Rebook for 2025-12-25 (same email)
→ Action: "updated", ID: abc-123 (SAME ID - booking was moved)
```

### Test 2: Past Booking → New Booking
```bash
# Manually insert past booking for 2025-11-10
→ Booking ID: xyz-789

# Create new booking for 2025-11-25 (same email)
→ Action: "created", ID: def-456 (DIFFERENT ID - new booking)

# Database now has 2 bookings:
# - xyz-789: 2025-11-10 (past)
# - def-456: 2025-11-25 (future)
```

## Running Tests

### Test 1: Future Booking Updates
```bash
./test-booking-logic.sh
```

### Test 2: Past Booking Scenario
```bash
./test-past-booking-scenario.sh
```

### Test 3: Survey Flow
```bash
./test-survey-flow.sh
```

## Database Schema

```sql
CREATE TABLE bookings (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  name TEXT NOT NULL,
  booking_date DATE NOT NULL,
  booking_time TIME NOT NULL,
  description TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  UNIQUE(booking_date, booking_time)  -- One booking per time slot
);
```

## API Endpoints

### POST `/api/bookings/`
Create or update a booking

**Request:**
```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "booking_date": "2025-12-20",
  "booking_time": "14:00",
  "description": "DevOps consultation"
}
```

**Response (Created):**
```json
{
  "action": "created",
  "booking": {
    "id": "abc-123",
    "email": "user@example.com",
    "name": "John Doe",
    "booking_date": "2025-12-20",
    "booking_time": "14:00:00",
    "description": "DevOps consultation",
    "created_at": "2025-11-15T07:00:00",
    "updated_at": "2025-11-15T07:00:00"
  },
  "message": "Your booking has been confirmed for 2025-12-20 at 14:00:00"
}
```

**Response (Updated):**
```json
{
  "action": "updated",
  "booking": { /* same structure as above */ },
  "message": "Your booking has been updated to 2025-12-20 at 14:00:00"
}
```

## Integration with Frontend

The frontend ([ContactSection.vue](src/components/ContactSection.vue) and [HeroSection.vue](src/components/HeroSection.vue)) handles both actions:

```typescript
if (result.action === 'created') {
  // Show green success toast
  toast.success(`🎉 Your audit has been booked successfully!`)
} else {
  // Show blue info toast
  toast.info(`✏️ Your audit has been updated successfully!`)
}
```

Both actions trigger:
1. Toast notification
2. Confirmation modal with survey
3. Google Chat webhook notification

## Edge Cases

1. **Time slot conflict**: If the new date/time is already booked by someone else, returns `409 Conflict`
2. **Today's date**: Rejected with `400 Bad Request` (bookings must be future)
3. **Past date**: Rejected with `400 Bad Request`
4. **Invalid date/time format**: Rejected with `422 Unprocessable Entity`

## Summary

The implementation ensures:
- ✅ Users can update their future bookings
- ✅ Past bookings don't block new bookings
- ✅ Each time slot can only have one booking (unique constraint)
- ✅ Proper notifications for create vs update actions
- ✅ Clear separation between past and future bookings
