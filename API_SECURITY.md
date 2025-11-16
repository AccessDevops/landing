# API Security Documentation

## Overview

This document describes the security measures implemented in the Booking API.

## Protected Endpoints

### Admin Endpoints (Require API Key)

The following endpoints are protected and require an `X-API-Key` header with a valid admin API key:

#### Bookings

1. **GET /api/bookings/future**
   - Lists all future bookings
   - Returns: Array of booking objects
   - Use case: Admin dashboard, reporting

2. **GET /api/bookings/{booking_id}**
   - Retrieves a specific booking by ID
   - Returns: Single booking object
   - Use case: Admin viewing booking details

3. **DELETE /api/bookings/{booking_id}**
   - Deletes a booking by ID
   - Returns: 204 No Content
   - Use case: Admin canceling bookings

#### Surveys

4. **GET /api/surveys/{booking_id}**
   - Retrieves survey responses for a specific booking
   - Returns: Survey object with all responses
   - Use case: Admin viewing customer feedback
   - **Protected since**: 2025-11-15
   - **Reason**: Contains sensitive customer data (roles, goals, team information)

### Public Endpoints (No API Key Required)

These endpoints are accessible to end users without authentication:

1. **POST /api/bookings/**
   - Create or update a booking
   - Public access needed for the booking form

2. **GET /api/bookings/available-slots**
   - Get available time slots for a date
   - Public access needed for the calendar picker

3. **POST /api/surveys**
   - Submit survey responses after booking
   - Public access needed for the survey form

4. **GET /health**
   - Health check endpoint
   - Public for monitoring

## Authentication Method

### API Key Authentication

Protected endpoints use API key authentication via the `X-API-Key` header.

**Configuration:**

1. Generate a secure API key:
   ```bash
   python3 -c "import secrets; print(secrets.token_urlsafe(32))"
   ```

2. Add to `backend/.env`:
   ```env
   ADMIN_API_KEY=your-generated-key-here
   ```

**Usage Example:**

```bash
# With API key (succeeds)
curl -X GET http://localhost:8000/api/bookings/future \
  -H "X-API-Key: your-admin-key"

# Without API key (fails with 401)
curl -X GET http://localhost:8000/api/bookings/future
```

**Error Responses:**

```json
// Missing API key
{
  "detail": "API Key is missing"
}

// Invalid API key
{
  "detail": "Invalid API Key"
}

// API key not configured on server
{
  "detail": "Admin API key not configured on server"
}
```

## Security Best Practices

### For Production Deployment

1. **Use Strong API Keys**
   - Minimum 32 characters
   - Use `secrets.token_urlsafe()` to generate
   - Never commit to version control

2. **Environment Variables**
   - Store `ADMIN_API_KEY` in environment variables
   - Use `.env` file (excluded from git)
   - Different keys for dev/staging/prod

3. **HTTPS Only**
   - Always use HTTPS in production
   - API keys transmitted in plain text over HTTP are vulnerable

4. **Key Rotation**
   - Rotate API keys periodically
   - Immediately rotate if compromised

5. **Access Control**
   - Only share admin keys with authorized personnel
   - Use different keys for different admin users/services if needed

### For Development

1. **Local Development**
   - Use a test API key in local `.env`
   - Don't use production keys locally

2. **Testing**
   - See [test-survey-api-protection.sh](test-survey-api-protection.sh) for examples

## Implementation Details

### Dependencies Module

Protected endpoints use the `verify_api_key` dependency:

```python
from ..dependencies import verify_api_key

@router.get("/protected-endpoint")
def protected_endpoint(
    api_key: str = Depends(verify_api_key)
):
    # Only executed if API key is valid
    pass
```

### Configuration

API key is loaded from environment in [backend/app/config.py](backend/app/config.py):

```python
class Settings(BaseSettings):
    admin_api_key: Optional[str] = None
```

### Verification Logic

See [backend/app/dependencies.py](backend/app/dependencies.py) for the `verify_api_key` implementation.

## Testing

### Manual Testing

```bash
# Test protected endpoint
./test-survey-api-protection.sh
```

### Expected Behavior

| Scenario | Expected Result |
|----------|----------------|
| No API key | 401 Unauthorized |
| Invalid API key | 401 Unauthorized |
| Valid API key | 200 OK with data |
| API key not configured | 401 with config error |

## Monitoring

### Recommended Monitoring

1. **Failed Authentication Attempts**
   - Monitor 401 errors on protected endpoints
   - Alert on unusual patterns

2. **API Key Usage**
   - Track which endpoints are accessed
   - Monitor for abnormal usage patterns

3. **Logs**
   - All authentication failures are logged
   - Review logs regularly for security issues

## Migration Notes

### Survey GET Protection (Added 2025-11-15)

Previously, `GET /api/surveys/{booking_id}` was unprotected. This has been changed to require admin authentication because:

1. Contains sensitive customer data (roles, cloud usage, team size, goals)
2. Not used by the frontend (only admin access needed)
3. Consistent with other read-only admin endpoints

**Impact:**
- No frontend changes needed (endpoint not used)
- Admin tools must now include `X-API-Key` header
- Existing integrations may break if they don't use API keys

## FAQ

**Q: Why isn't POST /api/bookings/ protected?**
A: End users need to create bookings through the public form. The endpoint has other protections (time slot uniqueness, validation).

**Q: Why isn't POST /api/surveys protected?**
A: Users need to submit surveys after booking. The endpoint verifies the booking exists and prevents duplicate submissions.

**Q: Can I use different API keys for different endpoints?**
A: Currently, all protected endpoints use the same `ADMIN_API_KEY`. If you need granular access control, you'll need to extend the authentication system.

**Q: What if I lose my API key?**
A: Generate a new one and update the `ADMIN_API_KEY` environment variable. Restart the server for changes to take effect.

## See Also

- [BOOKING_LOGIC.md](BOOKING_LOGIC.md) - Booking creation/update logic
- [backend/.env.example](backend/.env.example) - Configuration template
- [test-survey-api-protection.sh](test-survey-api-protection.sh) - Security tests
