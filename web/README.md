# Sehati Website & Admin Dashboard

Public landing page and admin dashboard for the Sehati Health App.

## Structure

- `index.html` - Public landing page (no authentication)
- `admin-login.html` - Admin login page
- `admin.html` - Admin dashboard (protected, requires authentication)
- `styles.css` - Shared design system styles
- `script.js` - Shared JavaScript utilities
- `backend/` - Node.js API server

## Design System

The website follows the exact same design system as the Flutter app:
- **Colors**: Matches `app_colors.dart` (light = old palette, dark = new OLED-friendly)
- **Typography**: Poppins font, Material Design 3 scale
- **Spacing**: 8/12/16/24/32px scale
- **Border Radius**: 8/12/16/28px
- **Shadows**: Consistent elevation hierarchy

## Setup

### Frontend (Static)

Simply open `index.html` in a browser or serve with any static server:

```bash
# Python
python3 -m http.server 8080

# Node.js
npx serve
```

### Backend API

See `backend/README.md` for setup instructions.

## Admin Access

1. Navigate to `/admin-login.html`
2. Login with admin credentials (configured in backend `.env`)
3. Access protected admin dashboard at `/admin.html`

**Important**: Admin dashboard is completely isolated from the public landing page. No admin links exist on the public site.

## Features

### Landing Page
- Hero section with app preview
- Features showcase
- User testimonials
- Call-to-action sections
- Responsive design

### Admin Dashboard
- Real-time data from Flutter app database
- User management
- Analytics & trends
- Workout & goal management
- AI insights overview
- Protected routes with JWT authentication

