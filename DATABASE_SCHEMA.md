# Sehati Database Schema

## Entity Relationship Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                    SEHATI DATABASE                                       │
│                                     Version: 4                                           │
└─────────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────┐
│       USERS         │
├─────────────────────┤
│ PK id              │◄─────────────────────────────────────────────────────────┐
│    name            │                                                          │
│ UK email           │──┐  (user_email references email)                        │
│    phone           │  │                                                       │
│    age             │  │                                                       │
│    gender          │  │                                                       │
│    height          │  │                                                       │
│    weight          │  │                                                       │
│    address         │  │                                                       │
│    xp              │  │                                                       │
│    level           │  │                                                       │
│    created_at      │  │                                                       │
│    updated_at      │  │                                                       │
└─────────────────────┘  │                                                       │
                         │                                                       │
         ┌───────────────┼───────────────┬───────────────┬───────────────┐       │
         │               │               │               │               │       │
         ▼               ▼               ▼               ▼               ▼       │
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│MEDICINE_REMINDERS│ │ MEDICINE_INTAKE │ │     MEALS       │ │    WORKOUTS     │ │  APPOINTMENTS   │
├─────────────────┤ ├─────────────────┤ ├─────────────────┤ ├─────────────────┤ ├─────────────────┤
│ PK id           │ │ PK id           │ │ PK id           │ │ PK id           │ │ PK id           │
│ FK user_email   │ │ FK user_email   │ │ FK user_email   │ │ FK user_email   │ │ FK user_email   │
│    medicine_name│ │    medicine_name│ │    name         │ │    name         │ │    type         │
│    dosage       │ │    dosage       │ │    meal_type    │ │    type         │ │    provider_name│
│    days_of_week │ │    intake_date  │ │    calories     │ │    duration     │ │    specialty    │
│    time         │ │    intake_time  │ │    protein      │ │    calories_    │ │    appointment_ │
│    is_active    │ │    is_taken     │ │    carbs        │ │      burned     │ │      date       │
│    created_at   │ │    created_at   │ │    fat          │ │    workout_date │ │    time         │
│    updated_at   │ │                 │ │    meal_date    │ │    created_at   │ │    status       │
└─────────────────┘ └─────────────────┘ │    created_at   │ └─────────────────┘ │    notes        │
                                        └─────────────────┘                     │    created_at   │
                                                                                │    updated_at   │
         ┌───────────────┬───────────────┬───────────────┐                      └─────────────────┘
         │               │               │               │
         ▼               ▼               ▼               ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ SLEEP_TRACKING  │ │  WATER_INTAKE   │ │  HEALTH_GOALS   │ │     ORDERS      │
├─────────────────┤ ├─────────────────┤ ├─────────────────┤ ├─────────────────┤
│ PK id           │ │ PK id           │ │ PK id           │ │ PK id           │
│ FK user_email   │ │ FK user_email   │ │ FK user_email   │ │ UK order_id     │
│    date         │ │    date         │ │    title        │ │    items (JSON) │
│    bedtime      │ │    amount       │ │    target       │ │    subtotal     │
│    wake_time    │ │    created_at   │ │    current      │ │    tax          │
│    duration     │ └─────────────────┘ │    progress     │ │    total        │
│    quality      │                     │    deadline     │ │    status       │
│    created_at   │                     │    created_at   │ │    shipping_    │
└─────────────────┘                     │    updated_at   │ │      address    │
                                        └─────────────────┘ │    payment_     │
                                                            │      method     │
                                                            │    created_at   │
                                                            │    updated_at   │
                                                            └─────────────────┘
```

---

## Table Definitions

### 1. USERS
Primary table storing user account information and gamification data.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique user identifier |
| `name` | TEXT | NOT NULL | User's full name |
| `email` | TEXT | NOT NULL, UNIQUE | User's email (login credential) |
| `phone` | TEXT | NULLABLE | Phone number |
| `age` | INTEGER | NULLABLE | User's age |
| `gender` | TEXT | NULLABLE | Gender (Male/Female/Other) |
| `height` | REAL | NULLABLE | Height in cm |
| `weight` | REAL | NULLABLE | Weight in kg |
| `address` | TEXT | NULLABLE | Delivery address |
| `xp` | INTEGER | DEFAULT 0 | Experience points |
| `level` | INTEGER | DEFAULT 1 | User level (xp/100 + 1) |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |
| `updated_at` | TEXT | NULLABLE | Last update timestamp |

---

### 2. MEDICINE_REMINDERS
Stores user's medication schedule and reminders.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique reminder ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `medicine_name` | TEXT | NOT NULL | Name of medicine |
| `dosage` | TEXT | NOT NULL | Dosage (e.g., "500mg") |
| `days_of_week` | TEXT | NOT NULL | JSON array [0-6] (Sun=0) |
| `time` | TEXT | NOT NULL | Time (HH:MM format) |
| `is_active` | INTEGER | DEFAULT 1 | 1=active, 0=paused |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |
| `updated_at` | TEXT | NULLABLE | Last update timestamp |

---

### 3. MEDICINE_INTAKE
Tracks actual medicine consumption history.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique intake ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `medicine_name` | TEXT | NOT NULL | Medicine taken |
| `dosage` | TEXT | NOT NULL | Dosage amount |
| `intake_date` | TEXT | NOT NULL | Date (YYYY-MM-DD) |
| `intake_time` | TEXT | NOT NULL | Scheduled time |
| `is_taken` | INTEGER | DEFAULT 0 | 1=taken, 0=pending |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |

---

### 4. MEALS
Nutrition tracking - stores logged meals.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique meal ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `name` | TEXT | NOT NULL | Meal name/description |
| `meal_type` | TEXT | NOT NULL | breakfast/lunch/dinner/snack |
| `calories` | REAL | NOT NULL | Calories (kcal) |
| `protein` | REAL | NOT NULL | Protein (grams) |
| `carbs` | REAL | NOT NULL | Carbohydrates (grams) |
| `fat` | REAL | NOT NULL | Fat (grams) |
| `meal_date` | TEXT | NOT NULL | Date (YYYY-MM-DD) |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |

---

### 5. WORKOUTS
Fitness tracking - stores exercise sessions.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique workout ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `name` | TEXT | NOT NULL | Workout name |
| `type` | TEXT | NOT NULL | cardio/strength/flexibility/etc |
| `duration` | INTEGER | NOT NULL | Duration in minutes |
| `calories_burned` | REAL | NOT NULL | Estimated calories burned |
| `workout_date` | TEXT | NOT NULL | Date (YYYY-MM-DD) |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |

---

### 6. APPOINTMENTS
Medical appointments and bookings.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique appointment ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `type` | TEXT | NOT NULL | clinic/lab/home_health |
| `provider_name` | TEXT | NOT NULL | Doctor/Lab name |
| `specialty` | TEXT | NOT NULL | Medical specialty |
| `appointment_date` | TEXT | NOT NULL | Date (YYYY-MM-DD) |
| `time` | TEXT | NOT NULL | Time (HH:MM) |
| `status` | TEXT | DEFAULT 'upcoming' | upcoming/completed/cancelled |
| `notes` | TEXT | NULLABLE | Additional notes |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |
| `updated_at` | TEXT | NULLABLE | Last update timestamp |

---

### 7. SLEEP_TRACKING
Sleep pattern monitoring.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique sleep ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `date` | TEXT | NOT NULL | Date (YYYY-MM-DD) |
| `bedtime` | TEXT | NULLABLE | Sleep time (HH:MM) |
| `wake_time` | TEXT | NULLABLE | Wake time (HH:MM) |
| `duration` | REAL | NULLABLE | Hours slept |
| `quality` | INTEGER | DEFAULT 3 | 1-5 rating |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |

---

### 8. WATER_INTAKE
Hydration tracking.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique intake ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `date` | TEXT | NOT NULL | Date (YYYY-MM-DD) |
| `amount` | INTEGER | NOT NULL | Amount in ml |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |

---

### 9. HEALTH_GOALS
User-defined health objectives.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique goal ID |
| `user_email` | TEXT | NOT NULL, FK→users.email | Owner's email |
| `title` | TEXT | NOT NULL | Goal title |
| `target` | TEXT | NOT NULL | Target value |
| `current` | TEXT | NOT NULL | Current progress |
| `progress` | REAL | NOT NULL | Percentage (0.0-1.0) |
| `deadline` | TEXT | NOT NULL | Target date |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |
| `updated_at` | TEXT | NULLABLE | Last update timestamp |

---

### 10. ORDERS
Pharmacy order history.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique order ID |
| `order_id` | TEXT | NOT NULL, UNIQUE | Display order ID (ORD-xxx) |
| `items` | TEXT | NOT NULL | JSON array of OrderItems |
| `subtotal` | REAL | NOT NULL | Subtotal amount |
| `tax` | REAL | NOT NULL | Tax amount |
| `total` | REAL | NOT NULL | Total amount |
| `status` | TEXT | DEFAULT 'pending' | pending/confirmed/shipped/delivered |
| `shipping_address` | TEXT | NULLABLE | Delivery address |
| `payment_method` | TEXT | NULLABLE | Payment type |
| `created_at` | TEXT | NOT NULL | ISO8601 timestamp |
| `updated_at` | TEXT | NULLABLE | Last update timestamp |

---

## Multi-User Architecture

### Complete Data Isolation

**Every user has their own isolated data.** Nothing is shared between users.

```
┌─────────────────────────────────────────────────────────────────┐
│                     MULTI-USER ISOLATION                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   USER A (user_a@email.com)      USER B (user_b@email.com)      │
│   ┌─────────────────────┐        ┌─────────────────────┐        │
│   │ • Medicine Reminders│        │ • Medicine Reminders│        │
│   │ • Medicine Intake   │        │ • Medicine Intake   │        │
│   │ • Meals             │   ✗    │ • Meals             │        │
│   │ • Workouts          │ ────── │ • Workouts          │        │
│   │ • Appointments      │  NO    │ • Appointments      │        │
│   │ • Sleep Tracking    │ SHARED │ • Sleep Tracking    │        │
│   │ • Water Intake      │  DATA  │ • Water Intake      │        │
│   │ • Health Goals      │        │ • Health Goals      │        │
│   │ • Orders            │        │ • Orders            │        │
│   │ • Cart              │        │ • Cart              │        │
│   │ • XP & Level        │        │ • XP & Level        │        │
│   └─────────────────────┘        └─────────────────────┘        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### How It Works

1. **Every table has `user_email` column** (except `users` table itself)
2. **All queries filter by `user_email`**
3. **Login/Logout refreshes all data** for the current user
4. **Switching accounts** clears previous user's data from memory

### Query Examples

```sql
-- User A's medicine reminders (User B cannot see these)
SELECT * FROM medicine_reminders WHERE user_email = 'user_a@email.com';

-- User B's meals (User A cannot see these)
SELECT * FROM meals WHERE user_email = 'user_b@email.com';

-- User A's today's water intake
SELECT SUM(amount) FROM water_intake 
WHERE user_email = 'user_a@email.com' 
AND DATE(date) = DATE('now');
```

### Provider Isolation (Flutter/Riverpod)

All providers watch `authProvider` and reload data when user changes:

```dart
// Example: RemindersProvider
class RemindersNotifier extends Notifier<List<MedicineReminderModel>> {
  @override
  List<MedicineReminderModel> build() {
    // Watch auth - auto-reload when user changes
    final authState = ref.watch(authProvider);
    
    if (authState.isAuthenticated && authState.user != null) {
      _loadReminders(authState.user!.email);  // Load THIS user's data only
    }
    return [];
  }
}
```

### Isolated Providers

| Provider | User Isolated |
|----------|---------------|
| `remindersProvider` | ✅ Filters by `user_email` |
| `medicineIntakeProvider` | ✅ Filters by `user_email` |
| `nutritionProvider` | ✅ Filters by `user_email` |
| `workoutsProvider` | ✅ Filters by `user_email` |
| `appointmentsProvider` | ✅ Filters by `user_email` |
| `healthTrackingProvider` | ✅ Filters by `user_email` |
| `ordersProvider` | ✅ Clears on logout |
| `cartProvider` | ✅ Clears on user change |
| `homeDataProvider` | ✅ Filters by `user_email` |
| `userProvider` | ✅ Syncs with `authProvider` |

### On Login

```dart
// When user logs in, all providers refresh with new user's data
void _invalidateAllUserProviders() {
  ref.invalidate(homeDataProvider);
  ref.invalidate(remindersProvider);
  ref.invalidate(medicineIntakeProvider);
  ref.invalidate(nutritionProvider);
  ref.invalidate(workoutsProvider);
  ref.invalidate(appointmentsProvider);
  ref.invalidate(healthTrackingProvider);
  ref.invalidate(ordersProvider);
  ref.invalidate(cartProvider);
}
```

### On Logout

- All user-specific state is cleared
- Cart is emptied
- Next login loads fresh data for new user

---

## Indexes (Recommended)

```sql
-- User lookups
CREATE INDEX idx_users_email ON users(email);

-- Medicine queries
CREATE INDEX idx_reminders_user ON medicine_reminders(user_email);
CREATE INDEX idx_intake_user_date ON medicine_intake(user_email, intake_date);

-- Nutrition queries
CREATE INDEX idx_meals_user_date ON meals(user_email, meal_date);

-- Workout queries
CREATE INDEX idx_workouts_user_date ON workouts(user_email, workout_date);

-- Appointment queries
CREATE INDEX idx_appointments_user ON appointments(user_email, appointment_date);

-- Health tracking
CREATE INDEX idx_sleep_user_date ON sleep_tracking(user_email, date);
CREATE INDEX idx_water_user_date ON water_intake(user_email, date);
CREATE INDEX idx_goals_user ON health_goals(user_email);
```

---

## Version History

| Version | Changes |
|---------|---------|
| 1 | Initial schema with basic tables |
| 2 | Added medicine_intake table |
| 3 | Added user_email to medicine tables |
| 4 | Added user_email to all remaining tables (full isolation) |

