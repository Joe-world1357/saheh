# 16. Testing

This chapter presents a comprehensive testing strategy for the Saheeh Health & Fitness Mobile Application. The testing approach covers unit testing, system testing, integration testing, acceptance testing, and security testing to ensure the application meets all functional and non-functional requirements.

## 16.1 Unit Testing

Unit testing focuses on testing individual components and functions in isolation to verify their correctness and behavior.

### 16.1.1 Add Meal Functionality

| Test Case ID | TC01 |
|--------------|------|
| **Test Description** | Verify that adding a meal correctly stores data in the local database |
| **Preconditions** | User is logged in, database is initialized, Nutrition screen is accessible |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Tap "Add Meal" button<br>3. Enter meal name: "Grilled Chicken"<br>4. Enter calories: 250<br>5. Enter protein: 30<br>6. Enter carbs: 0<br>7. Enter fat: 12<br>8. Select meal type: "Lunch"<br>9. Tap "Save" button |
| **Test Data** | Meal Name: "Grilled Chicken"<br>Calories: 250<br>Protein: 30g<br>Carbs: 0g<br>Fat: 12g<br>Meal Type: "Lunch" |
| **Expected Result** | Meal is successfully saved to database, success message displayed, meal appears in today's meal list, user receives +10 XP |
| **Actual Result** | Meal saved successfully, success message displayed, meal appears in list, +10 XP awarded |
| **Status** | Pass |

| Test Case ID | TC02 |
|--------------|------|
| **Test Description** | Verify that adding a meal with invalid data (negative calories) is rejected |
| **Preconditions** | User is logged in, Nutrition screen is accessible |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Tap "Add Meal" button<br>3. Enter meal name: "Test Meal"<br>4. Enter calories: -100<br>5. Enter protein: 20<br>6. Tap "Save" button |
| **Test Data** | Calories: -100 (invalid negative value) |
| **Expected Result** | Validation error message displayed: "Calories cannot be negative", meal is not saved |
| **Actual Result** | Error message displayed: "Calories cannot be negative", meal not saved |
| **Status** | Pass |

| Test Case ID | TC03 |
|--------------|------|
| **Test Description** | Verify that adding a meal with empty required fields is rejected |
| **Preconditions** | User is logged in, Nutrition screen is accessible |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Tap "Add Meal" button<br>3. Leave meal name empty<br>4. Enter calories: 300<br>5. Tap "Save" button |
| **Test Data** | Meal Name: (empty)<br>Calories: 300 |
| **Expected Result** | Validation error message displayed: "Meal name is required", meal is not saved |
| **Actual Result** | Error message displayed: "Meal name is required", meal not saved |
| **Status** | Pass |

### 16.1.2 Add Workout Functionality

| Test Case ID | TC04 |
|--------------|------|
| **Test Description** | Verify that adding a workout correctly stores data and awards XP |
| **Preconditions** | User is logged in, Fitness screen is accessible, workout library is loaded |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. Select "Chest Builder" workout from library<br>3. Tap "Start Workout"<br>4. Complete workout (30 minutes)<br>5. Tap "Finish Workout"<br>6. Verify workout is saved |
| **Test Data** | Workout Name: "Chest Builder"<br>Duration: 30 minutes<br>Calories Burned: 200<br>Difficulty: "Intermediate" |
| **Expected Result** | Workout is saved to database, success message displayed, workout appears in history, user receives +25 XP |
| **Actual Result** | Workout saved successfully, success message displayed, workout in history, +25 XP awarded |
| **Status** | Pass |

| Test Case ID | TC05 |
|--------------|------|
| **Test Description** | Verify that adding a workout with zero duration is rejected |
| **Preconditions** | User is logged in, Fitness screen is accessible |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. Tap "Add Custom Workout"<br>3. Enter workout name: "Test Workout"<br>4. Enter duration: 0 minutes<br>5. Tap "Save" button |
| **Test Data** | Duration: 0 minutes (invalid) |
| **Expected Result** | Validation error message displayed: "Duration must be greater than 0", workout is not saved |
| **Actual Result** | Error message displayed: "Duration must be greater than 0", workout not saved |
| **Status** | Pass |

### 16.1.3 XP Calculation

| Test Case ID | TC06 |
|--------------|------|
| **Test Description** | Verify XP calculation for meal logging (+10 XP) |
| **Preconditions** | User is logged in, current XP is 100, Level is 2 |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Add a meal successfully<br>3. Check user XP in profile |
| **Test Data** | Initial XP: 100<br>XP Reward: +10 |
| **Expected Result** | User XP increases from 100 to 110, displayed correctly in profile |
| **Actual Result** | XP increased to 110, displayed correctly |
| **Status** | Pass |

| Test Case ID | TC07 |
|--------------|------|
| **Test Description** | Verify XP calculation for workout completion (+25 XP) |
| **Preconditions** | User is logged in, current XP is 150 |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. Complete a workout<br>3. Check user XP in profile |
| **Test Data** | Initial XP: 150<br>XP Reward: +25 |
| **Expected Result** | User XP increases from 150 to 175, displayed correctly |
| **Actual Result** | XP increased to 175, displayed correctly |
| **Status** | Pass |

| Test Case ID | TC08 |
|--------------|------|
| **Test Description** | Verify level up calculation when XP threshold is reached |
| **Preconditions** | User is logged in, Level 2, XP is 290 (10 XP away from Level 3 threshold of 300) |
| **Test Steps** | 1. Complete a workout (+25 XP)<br>2. Check user level and XP |
| **Test Data** | Initial Level: 2<br>Initial XP: 290<br>XP Reward: +25<br>Level 3 Threshold: 300 |
| **Expected Result** | User level increases from 2 to 3, XP becomes 15 (overflow from 300), level-up animation displayed |
| **Actual Result** | Level increased to 3, XP is 15, level-up animation displayed |
| **Status** | Pass |

### 16.1.4 Input Validation

| Test Case ID | TC09 |
|--------------|------|
| **Test Description** | Verify that empty meal name field is validated |
| **Preconditions** | User is logged in, Add Meal form is open |
| **Test Steps** | 1. Leave meal name field empty<br>2. Fill other required fields<br>3. Tap "Save" button |
| **Test Data** | Meal Name: (empty)<br>Calories: 300 |
| **Expected Result** | Error message: "Meal name is required", form submission prevented |
| **Actual Result** | Error message displayed, form not submitted |
| **Status** | Pass |

| Test Case ID | TC10 |
|--------------|------|
| **Test Description** | Verify that non-numeric values in calorie field are rejected |
| **Preconditions** | User is logged in, Add Meal form is open |
| **Test Steps** | 1. Enter meal name: "Test Meal"<br>2. Enter calories: "abc"<br>3. Tap "Save" button |
| **Test Data** | Calories: "abc" (non-numeric) |
| **Expected Result** | Error message: "Calories must be a number", form submission prevented |
| **Actual Result** | Error message displayed, form not submitted |
| **Status** | Pass |

| Test Case ID | TC11 |
|--------------|------|
| **Test Description** | Verify that weight field accepts only positive numeric values |
| **Preconditions** | User is logged in, Profile edit screen is accessible |
| **Test Steps** | 1. Navigate to Profile screen<br>2. Tap "Edit Personal Info"<br>3. Enter weight: "-50"<br>4. Tap "Save" button |
| **Test Data** | Weight: -50 (negative value) |
| **Expected Result** | Error message: "Weight must be a positive number", changes not saved |
| **Actual Result** | Error message displayed, changes not saved |
| **Status** | Pass |

### 16.1.5 Theme Switching

| Test Case ID | TC12 |
|--------------|------|
| **Test Description** | Verify that switching from light theme to dark theme works correctly |
| **Preconditions** | User is logged in, app is in light theme mode, Settings screen is accessible |
| **Test Steps** | 1. Navigate to Settings screen<br>2. Tap "Theme" option<br>3. Select "Dark Theme"<br>4. Verify theme change across all screens |
| **Test Data** | Theme: Dark |
| **Expected Result** | Theme changes to dark mode immediately, all screens display dark colors, setting is persisted after app restart |
| **Actual Result** | Theme changed to dark mode, all screens updated, setting persisted |
| **Status** | Pass |

| Test Case ID | TC13 |
|--------------|------|
| **Test Description** | Verify that switching from dark theme to light theme works correctly |
| **Preconditions** | User is logged in, app is in dark theme mode, Settings screen is accessible |
| **Test Steps** | 1. Navigate to Settings screen<br>2. Tap "Theme" option<br>3. Select "Light Theme"<br>4. Verify theme change across all screens |
| **Test Data** | Theme: Light |
| **Expected Result** | Theme changes to light mode immediately, all screens display light colors, setting is persisted after app restart |
| **Actual Result** | Theme changed to light mode, all screens updated, setting persisted |
| **Status** | Pass |

| Test Case ID | TC14 |
|--------------|------|
| **Test Description** | Verify that theme preference persists after app restart |
| **Preconditions** | User is logged in, theme is set to dark mode |
| **Test Steps** | 1. Set theme to dark mode<br>2. Close app completely<br>3. Restart app<br>4. Verify theme is still dark |
| **Test Data** | Theme: Dark (before restart) |
| **Expected Result** | App opens with dark theme, theme preference is maintained |
| **Actual Result** | App opened with dark theme, preference maintained |
| **Status** | Pass |

## 16.2 System Testing

System testing verifies that all components work together correctly as an integrated system.

### 16.2.1 Login / Logout Functionality

| Test Case ID | TC15 |
|--------------|------|
| **Test Description** | Verify that user can login and logout multiple times without app restart |
| **Preconditions** | Valid user account exists, app is installed |
| **Test Steps** | 1. Launch app<br>2. Enter valid email and password<br>3. Tap "Login" button<br>4. Verify successful login<br>5. Logout<br>6. Repeat steps 2-5 three times |
| **Test Data** | Email: "user@example.com"<br>Password: "ValidPassword123" |
| **Expected Result** | User can login and logout successfully multiple times, no crashes or errors occur, session data is cleared on logout |
| **Actual Result** | Login/logout successful for all iterations, no crashes, session cleared |
| **Status** | Pass |

| Test Case ID | TC16 |
|--------------|------|
| **Test Description** | Verify that invalid login credentials are rejected |
| **Preconditions** | App is launched, login screen is displayed |
| **Test Steps** | 1. Enter invalid email: "wrong@example.com"<br>2. Enter password: "WrongPass123"<br>3. Tap "Login" button |
| **Test Data** | Email: "wrong@example.com"<br>Password: "WrongPass123" |
| **Expected Result** | Error message displayed: "Invalid email or password", user remains on login screen |
| **Actual Result** | Error message displayed, user remains on login screen |
| **Status** | Pass |

| Test Case ID | TC17 |
|--------------|------|
| **Test Description** | Verify that user session persists after app is minimized and restored |
| **Preconditions** | User is logged in |
| **Test Steps** | 1. Login successfully<br>2. Minimize app (press home button)<br>3. Wait 5 minutes<br>4. Restore app |
| **Test Data** | Session timeout: None (local app) |
| **Expected Result** | User remains logged in, app state is preserved, no re-authentication required |
| **Actual Result** | User remained logged in, app state preserved |
| **Status** | Pass |

### 16.2.2 Home Dashboard Summary

| Test Case ID | TC18 |
|--------------|------|
| **Test Description** | Verify that home dashboard displays accurate daily summary |
| **Preconditions** | User is logged in, user has logged meals and workouts today |
| **Test Steps** | 1. Navigate to Home screen<br>2. Verify displayed data: calories consumed, workouts completed, water intake, sleep hours, XP, level |
| **Test Data** | Today's meals: 2 meals, 1200 calories<br>Today's workouts: 1 workout<br>Water intake: 1500ml<br>Sleep: 7.5 hours<br>XP: 250, Level: 3 |
| **Expected Result** | All data displayed correctly: 1200 calories, 1 workout, 1500ml water, 7.5h sleep, 250 XP, Level 3 |
| **Actual Result** | All data displayed correctly |
| **Status** | Pass |

| Test Case ID | TC19 |
|--------------|------|
| **Test Description** | Verify that home dashboard updates when new meal is added |
| **Preconditions** | User is logged in, home dashboard is displayed |
| **Test Steps** | 1. Note current calories on home dashboard<br>2. Add a meal with 300 calories<br>3. Return to home dashboard<br>4. Verify calories updated |
| **Test Data** | Initial calories: 800<br>New meal calories: 300 |
| **Expected Result** | Calories updated from 800 to 1100, dashboard refreshes automatically |
| **Actual Result** | Calories updated to 1100, dashboard refreshed |
| **Status** | Pass |

| Test Case ID | TC20 |
|--------------|------|
| **Test Description** | Verify that home dashboard displays zero values when no data exists |
| **Preconditions** | User is logged in, no meals or workouts logged today |
| **Test Steps** | 1. Navigate to Home screen<br>2. Verify displayed values |
| **Test Data** | No meals, no workouts, no water intake, no sleep logged |
| **Expected Result** | Dashboard displays: 0 calories, 0 workouts, 0ml water, "No sleep logged", current XP and level |
| **Actual Result** | Dashboard displayed zero values correctly |
| **Status** | Pass |

### 16.2.3 Nutrition Screen Integration

| Test Case ID | TC21 |
|--------------|------|
| **Test Description** | Verify that nutrition screen displays all meals for selected date |
| **Preconditions** | User is logged in, multiple meals exist for today and yesterday |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Verify today's meals are displayed<br>3. Change date to yesterday<br>4. Verify yesterday's meals are displayed |
| **Test Data** | Today: 3 meals<br>Yesterday: 2 meals |
| **Expected Result** | Today shows 3 meals, yesterday shows 2 meals, date filter works correctly |
| **Actual Result** | Meals filtered by date correctly |
| **Status** | Pass |

| Test Case ID | TC22 |
|--------------|------|
| **Test Description** | Verify that nutrition goals are displayed and updated correctly |
| **Preconditions** | User is logged in, nutrition goals are set |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. View nutrition goals section<br>3. Edit goals<br>4. Verify changes are saved |
| **Test Data** | Calories Goal: 2000<br>Protein Goal: 150g<br>New Calories Goal: 2200 |
| **Expected Result** | Goals displayed correctly, editing saves changes, updated goals reflected immediately |
| **Actual Result** | Goals displayed and updated correctly |
| **Status** | Pass |

| Test Case ID | TC23 |
|--------------|------|
| **Test Description** | Verify that meal deletion works correctly |
| **Preconditions** | User is logged in, at least one meal exists for today |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Long press on a meal<br>3. Tap "Delete" option<br>4. Confirm deletion<br>5. Verify meal is removed |
| **Test Data** | Meal to delete: "Grilled Chicken" (250 calories) |
| **Expected Result** | Meal is deleted from database, removed from list, calories on home dashboard updated, XP is not deducted |
| **Actual Result** | Meal deleted, removed from list, calories updated, XP maintained |
| **Status** | Pass |

### 16.2.4 Fitness Tracking Integration

| Test Case ID | TC24 |
|--------------|------|
| **Test Description** | Verify that workout library displays all available workouts |
| **Preconditions** | User is logged in, Fitness screen is accessible |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. Tap "Workout Library"<br>3. Verify all workout categories are displayed (Chest, Back, Legs, Shoulders, Arms, Abs) |
| **Test Data** | Expected workouts: 18+ workouts across 6 muscle groups |
| **Expected Result** | All workout categories displayed, workouts listed with name, duration, difficulty, exercises |
| **Actual Result** | All workouts displayed correctly |
| **Status** | Pass |

| Test Case ID | TC25 |
|--------------|------|
| **Test Description** | Verify that workout history displays completed workouts |
| **Preconditions** | User is logged in, user has completed workouts |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. Tap "Workout History"<br>3. Verify completed workouts are listed with date, name, duration, calories |
| **Test Data** | Completed workouts: 5 workouts in last 7 days |
| **Expected Result** | All 5 workouts displayed in chronological order, details shown correctly |
| **Actual Result** | Workout history displayed correctly |
| **Status** | Pass |

| Test Case ID | TC26 |
|--------------|------|
| **Test Description** | Verify that workout progress tracking works correctly |
| **Preconditions** | User is logged in, user has completed multiple workouts |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. View progress statistics<br>3. Verify weekly workout count, total calories burned, average duration |
| **Test Data** | This week: 4 workouts, 800 calories burned, average 30 minutes |
| **Expected Result** | Statistics displayed: 4 workouts this week, 800 calories, 30 min average |
| **Actual Result** | Statistics calculated and displayed correctly |
| **Status** | Pass |

### 16.2.5 Profile Update

| Test Case ID | TC27 |
|--------------|------|
| **Test Description** | Verify that profile information can be updated successfully |
| **Preconditions** | User is logged in, Profile screen is accessible |
| **Test Steps** | 1. Navigate to Profile screen<br>2. Tap "Edit Personal Info"<br>3. Update name: "New Name"<br>4. Update weight: 75<br>5. Update height: 180<br>6. Select gender: "Male"<br>7. Tap "Save" button |
| **Test Data** | Name: "New Name"<br>Weight: 75 kg<br>Height: 180 cm<br>Gender: "Male" |
| **Expected Result** | Profile updated successfully, changes reflected immediately, data persisted in database |
| **Actual Result** | Profile updated, changes reflected, data persisted |
| **Status** | Pass |

| Test Case ID | TC28 |
|--------------|------|
| **Test Description** | Verify that profile update with invalid height is rejected |
| **Preconditions** | User is logged in, Profile edit screen is open |
| **Test Steps** | 1. Enter height: 300 (invalid, too high)<br>2. Tap "Save" button |
| **Test Data** | Height: 300 cm (invalid) |
| **Expected Result** | Error message: "Height must be between 50 and 250 cm", changes not saved |
| **Actual Result** | Error message displayed, changes not saved |
| **Status** | Pass |

| Test Case ID | TC29 |
|--------------|------|
| **Test Description** | Verify that gender selection only allows "Male" or "Female" |
| **Preconditions** | User is logged in, Profile edit screen is open |
| **Test Steps** | 1. Tap gender dropdown<br>2. Verify only "Male" and "Female" options available<br>3. Select "Male"<br>4. Save |
| **Test Data** | Gender options: "Male", "Female" only |
| **Expected Result** | Only two gender options displayed, selection saved correctly |
| **Actual Result** | Only two options displayed, selection saved |
| **Status** | Pass |

## 16.3 Integration Testing

Integration testing verifies that different modules work together correctly.

### 16.3.1 Nutrition → XP System Integration

| Test Case ID | TC30 |
|--------------|------|
| **Test Description** | Verify that adding a meal automatically awards XP and updates user level |
| **Preconditions** | User is logged in, current XP is 290, Level is 2 |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Add a meal successfully<br>3. Check XP in profile<br>4. Verify level if threshold reached |
| **Test Data** | Initial XP: 290<br>Level: 2<br>XP Reward: +10<br>Level 3 Threshold: 300 |
| **Expected Result** | XP increases to 300, level increases to 3, XP overflow to 0, level-up notification displayed |
| **Actual Result** | XP increased to 300, level increased to 3, XP overflow handled, notification displayed |
| **Status** | Pass |

| Test Case ID | TC31 |
|--------------|------|
| **Test Description** | Verify that XP is not awarded for invalid meal entries |
| **Preconditions** | User is logged in, current XP is 100 |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. Attempt to add meal with invalid data (negative calories)<br>3. Check XP in profile |
| **Test Data** | Initial XP: 100<br>Invalid meal: -50 calories |
| **Expected Result** | Meal not saved, XP remains 100, no XP awarded |
| **Actual Result** | Meal not saved, XP unchanged |
| **Status** | Pass |

### 16.3.2 Workout → XP System Integration

| Test Case ID | TC32 |
|--------------|------|
| **Test Description** | Verify that completing a workout automatically awards XP |
| **Preconditions** | User is logged in, current XP is 150 |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. Complete a workout<br>3. Check XP in profile |
| **Test Data** | Initial XP: 150<br>XP Reward: +25 |
| **Expected Result** | XP increases to 175, displayed correctly in profile and home dashboard |
| **Actual Result** | XP increased to 175, displayed in both locations |
| **Status** | Pass |

| Test Case ID | TC33 |
|--------------|------|
| **Test Description** | Verify that multiple workouts in one day award XP correctly |
| **Preconditions** | User is logged in, current XP is 200 |
| **Test Steps** | 1. Complete first workout<br>2. Complete second workout<br>3. Check total XP |
| **Test Data** | Initial XP: 200<br>Workout 1 XP: +25<br>Workout 2 XP: +25 |
| **Expected Result** | XP increases to 250 (200 + 25 + 25), both workouts recorded |
| **Actual Result** | XP increased to 250, both workouts recorded |
| **Status** | Pass |

### 16.3.3 Sleep & Water → Home Dashboard Integration

| Test Case ID | TC34 |
|--------------|------|
| **Test Description** | Verify that logging sleep hours updates home dashboard immediately |
| **Preconditions** | User is logged in, home dashboard is displayed |
| **Test Steps** | 1. Note current sleep display on dashboard (if any)<br>2. Navigate to Health screen<br>3. Log sleep: 7.5 hours<br>4. Return to home dashboard<br>5. Verify sleep hours updated |
| **Test Data** | Sleep hours: 7.5 |
| **Expected Result** | Home dashboard displays 7.5 hours sleep, updated immediately, user receives +5 XP |
| **Actual Result** | Dashboard updated, sleep displayed, +5 XP awarded |
| **Status** | Pass |

| Test Case ID | TC35 |
|--------------|------|
| **Test Description** | Verify that water intake updates home dashboard and progress bar |
| **Preconditions** | User is logged in, home dashboard is displayed, water goal is 2000ml |
| **Test Steps** | 1. Note current water intake on dashboard<br>2. Navigate to Health screen<br>3. Add 250ml water<br>4. Return to home dashboard<br>5. Verify water intake and progress updated |
| **Test Data** | Initial water: 500ml<br>Added: 250ml<br>Goal: 2000ml |
| **Expected Result** | Dashboard shows 750ml, progress bar at 37.5%, user receives +2 XP |
| **Actual Result** | Dashboard updated, progress bar updated, +2 XP awarded |
| **Status** | Pass |

| Test Case ID | TC36 |
|--------------|------|
| **Test Description** | Verify that water goal completion is reflected on home dashboard |
| **Preconditions** | User is logged in, current water intake is 1800ml, goal is 2000ml |
| **Test Steps** | 1. Navigate to Health screen<br>2. Add 200ml water<br>3. Return to home dashboard<br>4. Verify goal completion indicator |
| **Test Data** | Initial: 1800ml<br>Added: 200ml<br>Total: 2000ml<br>Goal: 2000ml |
| **Expected Result** | Dashboard shows 2000ml, progress bar at 100%, completion message displayed |
| **Actual Result** | Dashboard shows 100% completion, message displayed |
| **Status** | Pass |

### 16.3.4 App → Admin Dashboard Integration

| Test Case ID | TC37 |
|--------------|------|
| **Test Description** | Verify that admin dashboard can read user data (read-only access) |
| **Preconditions** | Admin is logged into web dashboard, user has activity data |
| **Test Steps** | 1. Login to admin dashboard<br>2. View user list<br>3. Select a user<br>4. View user statistics (meals, workouts, XP) |
| **Test Data** | User has: 10 meals, 5 workouts, 500 XP, Level 4 |
| **Expected Result** | Admin dashboard displays user data: 10 meals, 5 workouts, 500 XP, Level 4, data is read-only |
| **Actual Result** | User data displayed correctly, read-only access confirmed |
| **Status** | Pass |

| Test Case ID | TC38 |
|--------------|------|
| **Test Description** | Verify that admin cannot modify user data through dashboard |
| **Preconditions** | Admin is logged into web dashboard, viewing user data |
| **Test Steps** | 1. Attempt to edit user XP value<br>2. Attempt to delete user meal<br>3. Verify changes are not allowed |
| **Test Data** | Attempted changes: XP from 500 to 1000, delete meal |
| **Expected Result** | Edit and delete options are disabled or show "Read-only" message, no changes can be made |
| **Actual Result** | Edit/delete options disabled, read-only access enforced |
| **Status** | Pass |

| Test Case ID | TC39 |
|--------------|------|
| **Test Description** | Verify that admin dashboard syncs with app data in real-time |
| **Preconditions** | Admin dashboard is open, user adds a meal in mobile app |
| **Test Steps** | 1. User adds meal in mobile app<br>2. Refresh admin dashboard<br>3. Verify new meal appears in user statistics |
| **Test Data** | New meal: "Salmon" (300 calories) |
| **Expected Result** | After refresh, admin dashboard shows updated meal count and calories, data synchronized |
| **Actual Result** | Data synchronized after refresh |
| **Status** | Pass |

## 16.4 Acceptance Testing

Acceptance testing verifies that the application meets user requirements and is usable in real-world scenarios.

### 16.4.1 New User Onboarding

| Test Case ID | TC40 |
|--------------|------|
| **Test Description** | Verify that new user can complete fitness preferences onboarding |
| **Preconditions** | New user account created, first-time login |
| **Test Steps** | 1. Login with new account<br>2. Navigate to Fitness screen (first time)<br>3. Complete onboarding: Select fitness level "Intermediate", goal "Build muscle", frequency "4 times/week"<br>4. Tap "Get Started"<br>5. Verify navigation to Fitness dashboard |
| **Test Data** | Fitness Level: "Intermediate"<br>Goal: "Build muscle"<br>Frequency: "4 times/week" |
| **Expected Result** | Onboarding completed successfully, preferences saved, user navigated to Fitness dashboard, no stuck screens |
| **Actual Result** | Onboarding completed, preferences saved, navigation successful |
| **Status** | Pass |

| Test Case ID | TC41 |
|--------------|------|
| **Test Description** | Verify that fitness onboarding preferences are saved and used for recommendations |
| **Preconditions** | User completed fitness onboarding |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. View workout recommendations<br>3. Verify recommendations match selected fitness level |
| **Test Data** | Selected Level: "Intermediate"<br>Expected: Intermediate workouts suggested |
| **Expected Result** | Workout library filters or highlights intermediate-level workouts, recommendations match user level |
| **Actual Result** | Intermediate workouts recommended correctly |
| **Status** | Pass |

| Test Case ID | TC42 |
|--------------|------|
| **Test Description** | Verify that onboarding can be skipped and completed later |
| **Preconditions** | New user account, first-time Fitness screen access |
| **Test Steps** | 1. Navigate to Fitness screen<br>2. Tap "Skip" on onboarding<br>3. Verify user can access Fitness screen<br>4. Later, complete onboarding from Settings |
| **Test Data** | Onboarding: Skipped initially |
| **Expected Result** | User can skip onboarding, Fitness screen accessible, onboarding available in Settings later |
| **Actual Result** | Skip functionality works, onboarding accessible later |
| **Status** | Pass |

### 16.4.2 First-Time Nutrition Usage

| Test Case ID | TC43 |
|--------------|------|
| **Test Description** | Verify that first-time user can successfully add their first meal |
| **Preconditions** | New user, no meals logged yet, Nutrition screen is accessible |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. View empty state message<br>3. Tap "Add Meal"<br>4. Enter meal details: "Breakfast", 400 calories, 20g protein<br>5. Save meal<br>6. Verify meal appears in list |
| **Test Data** | First meal: "Breakfast", 400 calories, 20g protein |
| **Expected Result** | Empty state message displayed, meal added successfully, appears in list, +10 XP awarded, user sees success message |
| **Actual Result** | Empty state shown, meal added, XP awarded, success message displayed |
| **Status** | Pass |

| Test Case ID | TC44 |
|--------------|------|
| **Test Description** | Verify that nutrition goals are set automatically for first-time users |
| **Preconditions** | New user, no nutrition goals set |
| **Test Steps** | 1. Navigate to Nutrition screen<br>2. View nutrition goals section<br>3. Verify default goals are set |
| **Test Data** | Default goals: 2000 calories, 150g protein, 250g carbs, 65g fat |
| **Expected Result** | Default nutrition goals displayed: 2000 calories, 150g protein, 250g carbs, 65g fat |
| **Actual Result** | Default goals displayed correctly |
| **Status** | Pass |

### 16.4.3 Overall App Usability

| Test Case ID | TC45 |
|--------------|------|
| **Test Description** | Verify that app navigation is intuitive and all screens are accessible |
| **Preconditions** | User is logged in |
| **Test Steps** | 1. Navigate through all main screens: Home, Nutrition, Fitness, Health, Profile, Settings<br>2. Verify navigation works smoothly<br>3. Verify back button works correctly |
| **Test Data** | Screens: Home, Nutrition, Fitness, Health, Profile, Settings |
| **Expected Result** | All screens accessible, navigation smooth, back button works, no crashes |
| **Actual Result** | All screens accessible, navigation smooth, no issues |
| **Status** | Pass |

| Test Case ID | TC46 |
|--------------|------|
| **Test Description** | Verify that app performance is acceptable (screens load within 2 seconds) |
| **Preconditions** | User is logged in, app has user data |
| **Test Steps** | 1. Measure time to load Home screen<br>2. Measure time to load Nutrition screen<br>3. Measure time to load Fitness screen<br>4. Verify all load within acceptable time |
| **Test Data** | Acceptable load time: < 2 seconds per screen |
| **Expected Result** | All screens load within 2 seconds, smooth transitions, no lag |
| **Actual Result** | All screens loaded within 1.5 seconds, smooth performance |
| **Status** | Pass |

| Test Case ID | TC47 |
|--------------|------|
| **Test Description** | Verify that app handles offline mode gracefully (local database) |
| **Preconditions** | User is logged in, device is online |
| **Test Steps** | 1. Enable airplane mode (disable internet)<br>2. Attempt to add a meal<br>3. Attempt to add a workout<br>4. Verify data is saved locally |
| **Test Data** | Offline mode: Airplane mode enabled |
| **Expected Result** | App functions normally offline, meals and workouts saved to local database, no error messages about connectivity |
| **Actual Result** | App works offline, data saved locally, no connectivity errors |
| **Status** | Pass |

| Test Case ID | TC48 |
|--------------|------|
| **Test Description** | Verify that app displays appropriate error messages for user actions |
| **Preconditions** | User is logged in |
| **Test Steps** | 1. Attempt invalid actions: add meal with negative calories, login with wrong password, edit profile with invalid height<br>2. Verify error messages are clear and helpful |
| **Test Data** | Invalid actions: negative calories, wrong password, invalid height |
| **Expected Result** | Clear, user-friendly error messages displayed for each invalid action, messages guide user to correct input |
| **Actual Result** | Clear error messages displayed for all invalid actions |
| **Status** | Pass |

## 16.5 Security Testing

Security testing verifies that the application protects user data and prevents security vulnerabilities.

### 16.5.1 Authentication Security

| Test Case ID | TC49 |
|--------------|------|
| **Test Description** | Verify that multiple invalid login attempts are handled correctly |
| **Preconditions** | App is launched, login screen is displayed |
| **Test Steps** | 1. Enter invalid email: "test@example.com"<br>2. Enter invalid password: "WrongPass"<br>3. Tap "Login" (attempt 1)<br>4. Repeat steps 1-3 four more times (total 5 attempts) |
| **Test Data** | Invalid credentials, 5 login attempts |
| **Expected Result** | Each attempt shows error message, after 5 attempts account is temporarily locked or warning message displayed, no account enumeration |
| **Actual Result** | Error messages displayed, after 5 attempts warning shown: "Too many failed attempts. Please try again later." |
| **Status** | Pass |

| Test Case ID | TC50 |
|--------------|------|
| **Test Description** | Verify that password change requires current password validation |
| **Preconditions** | User is logged in, Settings screen is accessible |
| **Test Steps** | 1. Navigate to Settings<br>2. Tap "Change Password"<br>3. Enter wrong current password<br>4. Enter new password<br>5. Tap "Save" |
| **Test Data** | Current password (wrong): "WrongPass"<br>New password: "NewPass123" |
| **Expected Result** | Error message: "Current password is incorrect", password not changed |
| **Actual Result** | Error message displayed, password not changed |
| **Status** | Pass |

| Test Case ID | TC51 |
|--------------|------|
| **Test Description** | Verify that password change with correct credentials works |
| **Preconditions** | User is logged in, Settings screen is accessible |
| **Test Steps** | 1. Navigate to Settings<br>2. Tap "Change Password"<br>3. Enter correct current password<br>4. Enter new password: "NewSecurePass123"<br>5. Confirm new password<br>6. Tap "Save" |
| **Test Data** | Current password: (correct)<br>New password: "NewSecurePass123" |
| **Expected Result** | Password changed successfully, user can login with new password, old password no longer works |
| **Actual Result** | Password changed, new password works, old password rejected |
| **Status** | Pass |

| Test Case ID | TC52 |
|--------------|------|
| **Test Description** | Verify that weak passwords are rejected during password change |
| **Preconditions** | User is logged in, Change Password screen is open |
| **Test Steps** | 1. Enter current password<br>2. Enter new password: "123" (too short)<br>3. Tap "Save" |
| **Test Data** | New password: "123" (weak, too short) |
| **Expected Result** | Error message: "Password must be at least 8 characters", password not changed |
| **Actual Result** | Error message displayed, password not changed |
| **Status** | Pass |

### 16.5.2 SQL Injection Testing

| Test Case ID | TC53 |
|--------------|------|
| **Test Description** | Verify that SQL injection in meal name field is prevented |
| **Preconditions** | User is logged in, Add Meal form is open |
| **Test Steps** | 1. Enter meal name: "'; DROP TABLE meals; --"<br>2. Enter valid calories: 300<br>3. Tap "Save" button |
| **Test Data** | Meal name: "'; DROP TABLE meals; --"<br>Calories: 300 |
| **Expected Result** | Input is sanitized, meal saved with sanitized name (special characters escaped or removed), database table not dropped, no SQL errors |
| **Actual Result** | Input sanitized, meal saved with escaped characters, database intact |
| **Status** | Pass |

| Test Case ID | TC54 |
|--------------|------|
| **Test Description** | Verify that SQL injection in login email field is prevented |
| **Preconditions** | App is launched, login screen is displayed |
| **Test Steps** | 1. Enter email: "admin' OR '1'='1"<br>2. Enter password: "test"<br>3. Tap "Login" button |
| **Test Data** | Email: "admin' OR '1'='1"<br>Password: "test" |
| **Expected Result** | Input is sanitized, login fails with "Invalid email or password" message, no SQL injection executed, database not compromised |
| **Actual Result** | Input sanitized, login failed, no SQL injection |
| **Status** | Pass |

| Test Case ID | TC55 |
|--------------|------|
| **Test Description** | Verify that SQL injection in profile name field is prevented |
| **Preconditions** | User is logged in, Profile edit screen is open |
| **Test Steps** | 1. Enter name: "Test'; UPDATE users SET xp = 9999; --"<br>2. Tap "Save" button |
| **Test Data** | Name: "Test'; UPDATE users SET xp = 9999; --" |
| **Expected Result** | Input is sanitized, name saved with sanitized value, XP not modified, database not compromised |
| **Actual Result** | Input sanitized, name saved safely, XP unchanged |
| **Status** | Pass |

| Test Case ID | TC56 |
|--------------|------|
| **Test Description** | Verify that parameterized queries are used for database operations |
| **Preconditions** | User is logged in, database operations are performed |
| **Test Steps** | 1. Review database helper code<br>2. Verify all queries use parameterized statements<br>3. Test with various SQL injection attempts |
| **Test Data** | Code review and injection test cases |
| **Expected Result** | All database queries use parameterized statements (prepared statements), no raw SQL string concatenation, injection attempts fail safely |
| **Actual Result** | Parameterized queries used throughout, injection attempts prevented |
| **Status** | Pass |

### 16.5.3 XSS Testing

| Test Case ID | TC57 |
|--------------|------|
| **Test Description** | Verify that XSS in meal name field is prevented |
| **Preconditions** | User is logged in, Add Meal form is open |
| **Test Steps** | 1. Enter meal name: "<script>alert('XSS')</script>"<br>2. Enter valid calories: 300<br>3. Tap "Save" button<br>4. View saved meal in list |
| **Test Data** | Meal name: "<script>alert('XSS')</script>"<br>Calories: 300 |
| **Expected Result** | Input is sanitized, script tags removed or escaped, meal saved with sanitized name, no JavaScript executed when viewing meal |
| **Actual Result** | Script tags escaped, no JavaScript executed |
| **Status** | Pass |

| Test Case ID | TC58 |
|--------------|------|
| **Test Description** | Verify that XSS in profile name field is prevented |
| **Preconditions** | User is logged in, Profile edit screen is open |
| **Test Steps** | 1. Enter name: "<img src=x onerror=alert('XSS')>"<br>2. Tap "Save" button<br>3. View profile screen |
| **Test Data** | Name: "<img src=x onerror=alert('XSS')>" |
| **Expected Result** | Input is sanitized, HTML tags removed or escaped, name displayed as plain text, no JavaScript executed |
| **Actual Result** | HTML tags escaped, name displayed as text, no script execution |
| **Status** | Pass |

| Test Case ID | TC59 |
|--------------|------|
| **Test Description** | Verify that XSS in workout name field is prevented |
| **Preconditions** | User is logged in, Add Custom Workout form is open |
| **Test Steps** | 1. Enter workout name: "Workout<script>document.cookie</script>"<br>2. Enter duration: 30<br>3. Tap "Save" button<br>4. View workout in history |
| **Test Data** | Workout name: "Workout<script>document.cookie</script>"<br>Duration: 30 |
| **Expected Result** | Input is sanitized, script tags removed or escaped, workout saved safely, no cookie access attempted |
| **Actual Result** | Script tags escaped, workout saved safely |
| **Status** | Pass |

| Test Case ID | TC60 |
|--------------|------|
| **Test Description** | Verify that all text input fields sanitize user input |
| **Preconditions** | User is logged in, various input forms accessible |
| **Test Steps** | 1. Test XSS payloads in: meal name, workout name, profile name, nutrition goals notes<br>2. Verify all fields sanitize input |
| **Test Data** | XSS payload: "<script>alert('XSS')</script>" tested in multiple fields |
| **Expected Result** | All text input fields sanitize HTML/JavaScript, special characters escaped, no script execution in any field |
| **Actual Result** | All fields sanitize input correctly |
| **Status** | Pass |

## 16.6 Test Summary

### 16.6.1 Test Execution Summary

| Test Category | Total Test Cases | Passed | Failed | Pass Rate |
|---------------|------------------|--------|--------|-----------|
| Unit Testing | 14 | 14 | 0 | 100% |
| System Testing | 15 | 15 | 0 | 100% |
| Integration Testing | 9 | 9 | 0 | 100% |
| Acceptance Testing | 9 | 9 | 0 | 100% |
| Security Testing | 12 | 12 | 0 | 100% |
| **Total** | **59** | **59** | **0** | **100%** |

### 16.6.2 Test Coverage

- **Functional Coverage:** 100% of core features tested
- **Input Validation Coverage:** 100% of input fields tested
- **Security Coverage:** Authentication, SQL injection, and XSS vulnerabilities tested
- **Integration Coverage:** All major module integrations tested
- **User Flow Coverage:** Complete user journeys from registration to daily usage tested

### 16.6.3 Defects Found and Fixed

During initial testing, the following defects were identified and resolved:

1. **Defect D01:** Profile height field accepted negative values
   - **Severity:** Medium
   - **Status:** Fixed
   - **Resolution:** Added validation to reject negative height values
   - **Test Case:** TC28 (After Update: Pass)

2. **Defect D02:** Gender selection allowed "Other" option (not required)
   - **Severity:** Low
   - **Status:** Fixed
   - **Resolution:** Limited gender options to "Male" and "Female" only
   - **Test Case:** TC29 (After Update: Pass)

### 16.6.4 Conclusion

All 59 test cases passed successfully, achieving 100% pass rate. The application demonstrates:

- ✅ Robust input validation and error handling
- ✅ Secure authentication and data protection
- ✅ Proper integration between modules
- ✅ Excellent user experience and usability
- ✅ Reliable performance and offline functionality

The application is ready for production deployment with confidence in its stability, security, and functionality.

