# Integration Guide - Booking System

This document explains how the frontend Vue 3 application integrates with the FastAPI backend.

## Architecture

```
┌─────────────────┐         ┌──────────────────┐         ┌─────────────────┐
│   Vue 3 Frontend│  HTTP   │  FastAPI Backend │ Webhook │  Google Chat    │
│                 ├────────>│                  ├────────>│                 │
│  - HeroSection  │         │  - SQLite DB     │         │  Notifications  │
│  - TimeSlotPicker│         │  - CRUD API      │         │                 │
│  - BookingModal │         │  - Validation    │         │                 │
└─────────────────┘         └──────────────────┘         └─────────────────┘
```

## Setup

### 1. Backend Setup

```bash
cd backend
poetry install
cp .env.example .env
# Edit .env and add your Google Chat webhook URL
poetry run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Backend will be available at: http://localhost:8000

### 2. Frontend Setup

```bash
# In project root
cp .env.example .env
# Edit .env if needed (default: VITE_API_URL=http://localhost:8000)
pnpm dev
```

Frontend will be available at: http://localhost:5173

## API Integration

### Composable: `useBookingApi`

Located in `src/composables/useBookingApi.ts`, this composable handles all API communication.

**Functions:**
- `createBooking(data)` - Create or update a booking
- `getAvailableSlots(date)` - Get available time slots for a date
- `checkHealth()` - Health check endpoint

**State:**
- `isLoading` - Loading state
- `error` - Error message if any

### Component Integration

#### 1. TimeSlotPicker Component

**File:** `src/components/TimeSlotPicker.vue`

**Features:**
- Fetches available slots from API when date changes
- Displays available slots in green/white
- Displays booked slots as disabled (gray with strikethrough)
- Shows loading spinner while fetching slots

**API Call:**
```typescript
watch(() => props.selectedDate, async (newDate) => {
  if (newDate) {
    const dateString = newDate.toISOString().split('T')[0]
    const slots = await getAvailableSlots(dateString)
    availableSlots.value = slots
  }
})
```

#### 2. HeroSection Component

**File:** `src/components/HeroSection.vue`

**Features:**
- Handles booking submission
- Shows success/error messages
- Detects if booking was created or updated
- Passes loading state to modal

**API Call:**
```typescript
const handleBookingSubmit = async (data) => {
  const result = await createBooking({
    email: data.email,
    name: data.name,
    booking_date: bookingDate,
    booking_time: selectedTime.value,
    description: data.description,
  })

  if (result) {
    // Success - result.action is 'created' or 'updated'
    alert(`Your audit has been ${result.action === 'created' ? 'booked' : 'updated'}!`)
  }
}
```

#### 3. BookingModal Component

**File:** `src/components/BookingModal.vue`

**Features:**
- Accepts `isSubmitting` prop for loading state
- Disables form during submission
- Shows spinner and "Booking..." text when submitting

## Business Logic

### Smart Booking Updates

The system automatically handles booking updates:

1. **First booking:** User books a slot → Creates new booking
2. **Same email books again:** System updates existing booking instead of creating duplicate
3. **Conflict prevention:** If someone tries to book an already-taken slot → Returns error

### Example Flow

```
User: john@example.com
Action 1: Books Dec 15, 10:00 AM → Created ✅
Action 2: Books Dec 20, 2:00 PM  → Updated existing booking ✅
```

```
User: jane@example.com
Action: Books Dec 20, 2:00 PM → Error (slot taken by John) ❌
Action: Books Dec 20, 3:00 PM → Created ✅
```

## Environment Variables

### Frontend (.env)

```env
VITE_API_URL=http://localhost:8000
```

For production, update to your deployed backend URL:
```env
VITE_API_URL=https://api.yourdomain.com
```

### Backend (backend/.env)

```env
# Google Chat Webhook (required for notifications)
GOOGLE_CHAT_WEBHOOK_URL=https://chat.googleapis.com/v1/spaces/XXXXX/messages?key=XXXXX&token=XXXXX

# CORS Origins (update for production)
CORS_ORIGINS=["http://localhost:5173","https://yourdomain.com"]
```

## Testing the Integration

### 1. Test Available Slots

1. Start backend: `cd backend && poetry run uvicorn app.main:app --reload`
2. Start frontend: `pnpm dev`
3. Click "Book a Call" button
4. Select a date → TimeSlotPicker should load available slots

### 2. Test Booking Creation

1. Select a date and time
2. Click "Continue to Booking"
3. Fill in the form:
   - Name: Test User
   - Email: test@example.com
   - Description: Test booking
4. Click "Confirm Booking"
5. Should see success message
6. Check Google Chat for notification (if webhook configured)

### 3. Test Booking Update

1. Make another booking with same email (test@example.com)
2. Select different date/time
3. Submit → Should see "updated" message instead of "created"

### 4. Test Slot Conflict

1. Open two browser windows
2. In window 1: Select Dec 15, 10:00 AM
3. In window 2: Select same date/time
4. Submit in window 1 first → Success
5. Submit in window 2 → Should see error "This time slot is already booked"

## Error Handling

The frontend displays user-friendly error messages:

- **Slot already taken:** "This time slot is already booked. Please choose another time."
- **Invalid data:** Form validation prevents submission
- **API unavailable:** "An error occurred" message
- **Network errors:** Caught and displayed to user

All errors are logged to console for debugging.

## Google Chat Notifications

When configured, the backend sends rich card notifications to Google Chat:

**New Booking:**
```
✅ New Booking

👤 Name: John Doe
📧 Email: john@example.com
📅 Date: Wednesday, December 15, 2025
🕐 Time: 10:00 AM
📝 Description: Infrastructure audit discussion
```

**Updated Booking:**
```
🔄 Updated Booking

[Same format as above]
```

## Production Deployment

### Frontend

1. Update `.env` with production API URL
2. Build: `pnpm build`
3. Deploy `dist/` folder to hosting (Vercel, Netlify, etc.)

### Backend

1. Update `backend/.env` with:
   - Production Google Chat webhook
   - Production CORS origins
2. Deploy to Railway, Fly.io, or VPS
3. Ensure database persists (SQLite file or migrate to PostgreSQL)

### CORS Configuration

Update backend `CORS_ORIGINS` to include your production frontend URL:

```env
CORS_ORIGINS=["https://yourdomain.com","https://www.yourdomain.com"]
```

## Troubleshooting

### Slots not loading
- Check backend is running on port 8000
- Check browser console for CORS errors
- Verify `VITE_API_URL` in frontend `.env`

### Booking submission fails
- Check backend logs for errors
- Verify email format is valid
- Check if time slot was taken between selection and submission

### Google Chat notifications not sending
- Verify webhook URL in `backend/.env`
- Test webhook with curl:
  ```bash
  curl -X POST YOUR_WEBHOOK_URL \
    -H 'Content-Type: application/json' \
    -d '{"text":"Test message"}'
  ```

### CORS errors in production
- Add production domain to `CORS_ORIGINS` in backend
- Rebuild and redeploy backend
- Clear browser cache

## API Documentation

When backend is running, visit:
- Interactive docs: http://localhost:8000/docs
- Alternative docs: http://localhost:8000/redoc

## Support

For issues or questions:
- Check backend logs: Terminal running uvicorn
- Check frontend console: Browser DevTools → Console
- Review API docs: http://localhost:8000/docs
