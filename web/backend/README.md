# Sehati Admin API

Backend API server for the Sehati Admin Dashboard.

## Setup

1. Install dependencies:
```bash
cd web/backend
npm install
```

2. Create `.env` file (copy from `.env.example`):
```bash
cp .env.example .env
```

3. Update `.env` with your settings:
```
ADMIN_EMAIL=admin@sehati.com
ADMIN_PASSWORD=your-secure-password
JWT_SECRET=your-secret-key
PORT=3000
DB_PATH=~/.local/share/com.example.sehati/sehati.db
```

4. Start the server:
```bash
npm start
```

Or for development with auto-reload:
```bash
npm run dev
```

## API Endpoints

### Authentication
- `POST /api/auth/login` - Admin login
- `GET /api/auth/verify` - Verify token

### Admin (Protected)
- `GET /api/admin/overview` - Dashboard overview stats
- `GET /api/admin/users` - Get all users
- `GET /api/admin/users/:id` - Get user details
- `GET /api/admin/analytics/activity` - Activity trends
- `GET /api/admin/analytics/sleep` - Sleep trends
- `GET /api/admin/analytics/water` - Water intake trends
- `GET /api/admin/analytics/xp` - XP progression
- `GET /api/admin/workouts` - Get workouts
- `POST /api/admin/workouts` - Add workout
- `GET /api/admin/goals` - Get goals
- `PUT /api/admin/goals/:id` - Update goal
- `DELETE /api/admin/goals/:id` - Delete goal
- `GET /api/admin/insights` - Get AI insights

## Security

- All admin routes require JWT authentication
- Single admin role (no user signup)
- Protected routes with middleware
- Session stored in localStorage (frontend)

## Database

The API reads from the Flutter app's SQLite database. Make sure the database path in `.env` matches your system.

**Linux**: `~/.local/share/com.example.sehati/sehati.db`
**Windows**: `%LOCALAPPDATA%\com.example.sehati\sehati.db`
**macOS**: `~/Library/Application Support/com.example.sehati/sehati.db`

