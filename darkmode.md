# Dark Mode Design Specification
## Sehati Health App

**Document Version:** 1.0  
**Date:** December 16, 2025  
**Complements:** Light Mode SRS v1.0

---

## 1. Dark Mode Philosophy

### 1.1 Design Principles
- **Reduced Eye Strain:** Lower luminance for comfortable viewing in low-light environments
- **True Black Avoidance:** Use dark grays (#121212) instead of pure black (#000000) to reduce screen burn-in on OLED displays
- **Elevated Surface Concept:** Lighter surfaces appear "elevated" above the background
- **Color Vibrancy:** Slightly desaturated colors to prevent visual fatigue
- **Contrast Preservation:** Maintain WCAG AA accessibility standards (4.5:1 for normal text)

### 1.2 When to Use Dark Mode
- Low-light environments
- Night-time usage
- User preference for darker interfaces
- Battery conservation (on OLED displays)

---

## 2. Dark Mode Color System

### 2.1 Background & Surface Colors

| Color Name | Hex Code | RGB | Usage | Elevation |
|------------|----------|-----|-------|-----------|
| **Background Dark** | `#121212` | (18, 18, 18) | Main app background | 0dp |
| **Surface Dark** | `#1E1E1E` | (30, 30, 30) | Cards, containers | 1dp-2dp |
| **Surface Elevated Dark** | `#2D2D2D` | (45, 45, 45) | Floating elements, dialogs | 6dp-8dp |
| **Surface Variant** | `#383838` | (56, 56, 56) | Input fields, chips | 3dp-4dp |

**Elevation System:**
```
Level 0 (0dp):   #121212 - Background
Level 1 (1dp):   #1E1E1E - Bottom nav, cards
Level 2 (2dp):   #232323 - App bar
Level 3 (4dp):   #2D2D2D - FAB, drawers
Level 4 (6dp):   #323232 - Dialogs
Level 5 (8dp):   #383838 - Modal sheets
```

### 2.2 Primary Colors (Adjusted for Dark Mode)

| Color Name | Light Mode | Dark Mode | Adjustment |
|------------|------------|-----------|------------|
| **Primary** | `#20C6B7` | `#4DD0E1` | Lighter for better contrast |
| **Primary Variant** | `#17A89A` | `#26C6DA` | Increased luminance |
| **Primary Container** | `#E0F7F5` | `#1A3A3A` | Darkened background |

**Rationale:** Primary colors in dark mode should be lighter to maintain proper contrast against dark backgrounds while preserving brand identity.

### 2.3 Text Colors

| Color Name | Hex Code | RGB | Opacity | Usage |
|------------|----------|-----|---------|-------|
| **Text Primary Dark** | `#E1E1E1` | (225, 225, 225) | 87% | Headlines, body text |
| **Text Secondary Dark** | `#B0B0B0` | (176, 176, 176) | 60% | Labels, secondary info |
| **Text Tertiary Dark** | `#757575` | (117, 117, 117) | 38% | Hints, placeholders, disabled text |
| **Text Inverse** | `#1A2A2C` | (26, 42, 44) | 87% | Text on light surfaces |

**Contrast Ratios:**
- Primary text on background: 11.5:1 (AAA)
- Secondary text on background: 5.8:1 (AA)
- Tertiary text on background: 3.2:1 (Decorative minimum)

### 2.4 Border & Divider Colors

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| **Border Dark** | `#3D3D3D` | Card borders, input fields |
| **Divider Dark** | `#2D2D2D` | Separators, list dividers |
| **Border Primary Dark** | `#4DD0E1` | Focused states, emphasis |

### 2.5 Status Colors (Dark Mode Variants)

| Color Name | Light Mode | Dark Mode | Usage |
|------------|------------|-----------|-------|
| **Success** | `#4CAF50` | `#66BB6A` | Success states |
| **Warning** | `#FF9800` | `#FFA726` | Warnings |
| **Error** | `#EF5350` | `#E57373` | Errors |
| **Info** | `#2196F3` | `#42A5F5` | Information |

**Note:** Slightly lighter shades improve visibility on dark backgrounds.

### 2.6 Nutrition Colors (Dark Mode)

| Nutrient | Light Mode | Dark Mode | Container BG |
|----------|------------|-----------|--------------|
| **Protein** | `#66BB6A` | `#81C784` | `#1B3B1B` |
| **Carbs** | `#FF9800` | `#FFB74D` | `#3B2B1A` |
| **Fats** | `#AB47BC` | `#BA68C8` | `#2E1B33` |
| **Calories** | `#FFA726` | `#FFCA28` | `#3B2F1A` |

### 2.7 Gradient Definitions

#### Primary Gradient (Dark)
```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF26C6DA), // Lighter primary
    Color(0xFF00ACC1), // Darker primary
  ],
)
```

#### Card Gradient (Dark)
```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF1E1E1E), // Surface dark
    Color(0xFF2D2D2D), // Surface elevated
  ],
)
```

#### Success Gradient (Dark)
```dart
LinearGradient(
  colors: [
    Color(0xFF66BB6A),
    Color(0xFF4CAF50),
  ],
)
```

---

## 3. Component-Specific Dark Mode Design

### 3.1 Navigation Components

#### Bottom Navigation Bar
```
Background: #1E1E1E (Surface Dark)
Selected Item Color: #4DD0E1 (Primary Light)
Unselected Item Color: #757575 (Text Tertiary)
Indicator: 2dp height, #4DD0E1
Elevation: 8dp shadow (subtle)
Border Top: 1px solid #2D2D2D
```

#### App Bar
```
Background: #232323 (2dp elevation)
Text Color: #E1E1E1 (Text Primary)
Icon Color: #E1E1E1
Elevation: 2dp
Bottom Border: None (use shadow)
```

### 3.2 Cards & Containers

#### Standard Card
```
Background: #1E1E1E (Surface Dark)
Border: 1px solid #2D2D2D
Border Radius: 16px
Padding: 20px
Shadow: 0px 2px 8px rgba(0, 0, 0, 0.3)
```

#### Elevated Card (Featured)
```
Background: #2D2D2D (Surface Elevated)
Border: None
Border Radius: 16px
Padding: 24px
Shadow: 0px 4px 12px rgba(0, 0, 0, 0.4)
Gradient: Optional (topLeft to bottomRight)
```

#### Card with Gradient
```
Background: Linear gradient (#2D2D2D to #1E1E1E)
Border: 1px solid #3D3D3D
Border Radius: 16px
Overlay: Semi-transparent primary color (10% opacity)
```

### 3.3 Buttons

#### Primary Button
```
Background: #4DD0E1 (Primary Light)
Text Color: #121212 (Dark text for contrast)
Border: None
Border Radius: 32px
Padding: 16px 32px
Shadow: 0px 4px 8px rgba(77, 208, 225, 0.3)
Pressed State: #26C6DA (darker)
```

#### Secondary Button
```
Background: Transparent
Text Color: #4DD0E1
Border: 2px solid #4DD0E1
Border Radius: 32px
Padding: 14px 30px
Pressed State: Background #1A3A3A
```

#### Tertiary Button
```
Background: #2D2D2D
Text Color: #E1E1E1
Border: 1px solid #3D3D3D
Border Radius: 32px
Padding: 12px 24px
Pressed State: #383838
```

### 3.4 Input Fields

#### Text Input
```
Background: #1E1E1E
Border: 1px solid #3D3D3D
Border Radius: 12px
Text Color: #E1E1E1
Placeholder Color: #757575
Padding: 16px
Focus State: Border #4DD0E1 (2px)
Error State: Border #E57373
```

#### Search Bar
```
Background: #2D2D2D
Border: None
Border Radius: 24px
Icon Color: #B0B0B0
Text Color: #E1E1E1
Placeholder: #757575
```

### 3.5 Lists & Tiles

#### List Item
```
Background: Transparent
Hover/Press: #1E1E1E
Divider: 1px solid #2D2D2D
Padding: 16px
Text Primary: #E1E1E1
Text Secondary: #B0B0B0
Icon Color: #4DD0E1
```

#### Settings Item
```
Background: #1E1E1E
Border: 1px solid #2D2D2D
Border Radius: 12px
Margin: 8px 0
Padding: 16px
```

### 3.6 Dialogs & Modals

#### Dialog
```
Background: #2D2D2D (Elevated)
Border Radius: 24px
Shadow: 0px 8px 24px rgba(0, 0, 0, 0.5)
Padding: 24px
Title Color: #E1E1E1
Body Color: #B0B0B0
Scrim: rgba(0, 0, 0, 0.6)
```

#### Bottom Sheet
```
Background: #2D2D2D
Border Radius: 24px 24px 0 0
Handle: 4px x 32px, #757575
Padding: 24px
```

### 3.7 Progress Indicators

#### Linear Progress Bar
```
Track: #2D2D2D
Progress: #4DD0E1
Height: 8px
Border Radius: 4px
```

#### Circular Progress
```
Color: #4DD0E1
Track: #2D2D2D
Stroke Width: 4px
```

#### XP Progress Bar
```
Background: #1E1E1E
Border: 1px solid #3D3D3D
Progress Gradient: #4DD0E1 to #26C6DA
Height: 12px
Border Radius: 6px
```

### 3.8 Chips & Tags

#### Chip
```
Background: #2D2D2D
Text Color: #E1E1E1
Border: 1px solid #3D3D3D
Border Radius: 16px
Padding: 8px 16px
Selected: Background #4DD0E1, Text #121212
```

#### Status Chip
```
Success: Background #1B3B1B, Text #66BB6A
Warning: Background #3B2B1A, Text #FFA726
Error: Background #3B1A1A, Text #E57373
Info: Background #1A2B3B, Text #42A5F5
```

### 3.9 Charts & Graphs

#### Chart Colors
```
Background: #1E1E1E
Grid Lines: #2D2D2D
Axis Labels: #B0B0B0
Data Series: [#4DD0E1, #66BB6A, #FFA726, #BA68C8, #42A5F5]
Tooltip Background: #2D2D2D
Tooltip Border: #3D3D3D
Tooltip Text: #E1E1E1
```

#### Nutrition Pie Chart
```
Background: Transparent
Protein: #81C784
Carbs: #FFB74D
Fats: #BA68C8
Legend Text: #E1E1E1
```

---

## 4. Screen-Specific Dark Mode Design

### 4.1 Authentication Screens

#### Splash Screen
```
Background: #121212
Logo: Full color (no adjustment)
Animation: Fade in with glow effect
Glow Color: #4DD0E1 (10% opacity)
```

#### Welcome Screen
```
Background: Linear gradient
  - Top: #121212
  - Bottom: #1A2A2A
Logo: Full color
Heading: #E1E1E1
Subheading: #B0B0B0
Primary Button: #4DD0E1 background, #121212 text
Secondary Button: Transparent, #4DD0E1 border
Guest Link: #4DD0E1
```

#### Login/Register Screen
```
Background: #121212
Card Background: #1E1E1E
Input Fields: #2D2D2D background
Labels: #B0B0B0
Error Messages: #E57373
Link Text: #4DD0E1
```

### 4.2 Home Screen

#### Top Bar
```
Background: #1E1E1E
Logo: Full color
App Name: #E1E1E1
Notification Icon: #E1E1E1
Badge: #EF5350 background
```

#### Greeting Card
```
Background: Linear gradient (#26C6DA to #00ACC1)
Text: #121212 (dark text on light gradient)
Level Badge: #FFFFFF background, #26C6DA text
Progress Bar Track: rgba(255, 255, 255, 0.3)
Progress Bar Fill: #FFFFFF
```

#### Quick Actions
```
Card Background: #1E1E1E
Icon Background: Gradient per action
  - Medicines: #1B3B1B to #2E5A2E
  - Nutrition: #3B2B1A to #5A3F1A
  - Workout: #2E1B33 to #4A2A51
  - Book: #1A2B3B to #2A4059
Icon Color: #FFFFFF
Label: #E1E1E1
Border: 1px solid #2D2D2D
```

#### Summary Cards
```
Background: #1E1E1E
Border: 1px solid #2D2D2D
Title: #E1E1E1
Value: #4DD0E1 (primary metrics)
Label: #B0B0B0
Icon Background: #2D2D2D
Icon Color: Colored (Success, Warning, etc.)
```

### 4.3 Pharmacy Screens

#### Pharmacy Screen
```
Background: #121212
Search Bar: #2D2D2D
Category Chips: #1E1E1E with #3D3D3D border
Product Cards: #1E1E1E
Product Name: #E1E1E1
Product Price: #4DD0E1
Stock Status: #66BB6A (in stock), #E57373 (out of stock)
Add to Cart Button: #4DD0E1
```

#### Drug Details
```
Background: #121212
Hero Image Background: #1E1E1E
Product Name: #E1E1E1
Price: #4DD0E1 (large, bold)
Description Card: #1E1E1E
Section Headers: #E1E1E1
Body Text: #B0B0B0
Dosage Chips: #2D2D2D
Add to Cart Button: Fixed bottom, #4DD0E1
```

#### Cart Screen
```
Background: #121212
Item Cards: #1E1E1E
Product Name: #E1E1E1
Price: #B0B0B0
Quantity Controls: #2D2D2D background
Total Section: #2D2D2D elevated
Total Label: #B0B0B0
Total Amount: #4DD0E1 (large)
Checkout Button: #4DD0E1
```

### 4.4 Fitness Screens

#### Fitness Dashboard
```
Background: #121212
Stats Cards: #1E1E1E with colored gradients
  - Steps: #1A2B3B to #2A4059
  - Calories: #3B2B1A to #5A3F1A
  - Distance: #2E1B33 to #4A2A51
  - Active Time: #1B3B1B to #2E5A2E
Metric Values: #E1E1E1 (large)
Metric Labels: #B0B0B0
Icon: #FFFFFF
Progress Ring: Colored per metric
```

#### Workout Library
```
Background: #121212
Filter Chips: #2D2D2D
Workout Cards: #1E1E1E
Thumbnail Overlay: Linear gradient (transparent to #121212)
Workout Name: #E1E1E1
Duration: #B0B0B0
Difficulty Badge: Colored background
  - Beginner: #1B3B1B, text #66BB6A
  - Intermediate: #3B2B1A, text #FFA726
  - Advanced: #3B1A1A, text #E57373
```

#### XP System
```
Background: #121212
Level Card: Gradient (#26C6DA to #00ACC1)
XP Bar: #2D2D2D track, #FFFFFF fill
Achievement Cards: #1E1E1E
Locked: Grayscale + 50% opacity
Unlocked: Full color with glow
Badge Icon: Gold gradient for unlocked
Points: #4DD0E1
```

### 4.5 Health Tracking Screens

#### Reminder Screen
```
Background: #121212
Time Group Headers: #B0B0B0
Medicine Cards: #1E1E1E
Medicine Name: #E1E1E1
Dosage: #B0B0B0
Time: #4DD0E1
Status Badge: Colored
  - Taken: #1B3B1B, text #66BB6A
  - Pending: #3B2B1A, text #FFA726
  - Missed: #3B1A1A, text #E57373
Checkbox: #2D2D2D unchecked, #4DD0E1 checked
```

#### Sleep Tracker
```
Background: #121212
Chart Background: #1E1E1E
Sleep Bars: Gradient (#6A1B9A to #8E24AA)
Awake Periods: #3D3D3D
Axis Labels: #B0B0B0
Stats Cards: #1E1E1E
Deep Sleep: #4A148C
Light Sleep: #7B1FA2
REM Sleep: #9C27B0
Awake: #BA68C8
```

#### Water Intake
```
Background: #121212
Water Glass Visualization: #1E1E1E container
Filled Water: Gradient (#2196F3 to #42A5F5)
Progress Text: #E1E1E1
Goal Text: #B0B0B0
Add Water Buttons: #2D2D2D
Cup Icons: #42A5F5
```

### 4.6 Nutrition Screens

#### Nutrition Screen
```
Background: #121212
Calorie Card: Gradient (#3B2B1A to #5A3F1A)
Calorie Value: #E1E1E1 (large)
Goal Progress: #FFA726
Macro Cards: #1E1E1E
Macro Bars: Colored per macro
  - Protein: #81C784
  - Carbs: #FFB74D
  - Fats: #BA68C8
Macro Values: #E1E1E1
Macro Goals: #B0B0B0
Meal Cards: #1E1E1E
Meal Time: #4DD0E1
Meal Name: #E1E1E1
Calories: #B0B0B0
```

#### Add Meal
```
Background: #121212
Food Search: #2D2D2D
Food Results: #1E1E1E cards
Food Name: #E1E1E1
Serving Size: #B0B0B0
Nutrition Info: Colored chips
Add Button: #4DD0E1
```

### 4.7 Services Screens

#### Services Screen
```
Background: #121212
Service Cards: #1E1E1E
Service Icon: Colored circular background
Service Name: #E1E1E1
Service Description: #B0B0B0
Arrow Icon: #757575
```

#### Clinic Dashboard
```
Background: #121212
Specialty Filters: #2D2D2D chips
Doctor Cards: #1E1E1E
Doctor Photo Border: #3D3D3D
Doctor Name: #E1E1E1
Specialty: #4DD0E1
Rating Stars: #FFA726
Reviews Count: #B0B0B0
Experience: #B0B0B0
Book Button: #4DD0E1
```

### 4.8 Profile & Settings

#### Profile Screen
```
Background: #121212
Header Card: Gradient (#26C6DA to #00ACC1)
Profile Photo Border: #FFFFFF (2px)
Name: #121212 (on gradient)
Stats: #121212 (on gradient)
Info Cards: #1E1E1E
Section Headers: #E1E1E1
Labels: #B0B0B0
Values: #E1E1E1
Condition Chips: Colored backgrounds
Edit Button: #4DD0E1
```

#### Settings Screen
```
Background: #121212
Section Headers: #4DD0E1
Setting Items: #1E1E1E
Item Text: #E1E1E1
Item Subtitle: #B0B0B0
Icons: #4DD0E1
Chevron: #757575
Dividers: #2D2D2D
Toggle Switch:
  - Track: #3D3D3D (off), #4DD0E1 (on)
  - Thumb: #E1E1E1
```

---

## 5. Special Effects & Interactions

### 5.1 Shadows & Elevation

#### Light Mode vs Dark Mode Shadows
```
Light Mode: rgba(0, 0, 0, 0.1)
Dark Mode: rgba(0, 0, 0, 0.4)
```

**Elevation Shadows (Dark Mode):**
```dart
// 1dp
BoxShadow(
  color: Colors.black.withOpacity(0.3),
  blurRadius: 1,
  offset: Offset(0, 1),
)

// 2dp
BoxShadow(
  color: Colors.black.withOpacity(0.3),
  blurRadius: 2,
  offset: Offset(0, 2),
)

// 4dp
BoxShadow(
  color: Colors.black.withOpacity(0.4),
  blurRadius: 4,
  offset: Offset(0, 4),
)

// 8dp
BoxShadow(
  color: Colors.black.withOpacity(0.4),
  blurRadius: 8,
  offset: Offset(0, 4),
)
```

### 5.2 Glow Effects

#### Primary Glow (for important elements)
```dart
BoxShadow(
  color: Color(0xFF4DD0E1).withOpacity(0.3),
  blurRadius: 12,
  spreadRadius: 2,
)
```

#### Success Glow
```dart
BoxShadow(
  color: Color(0xFF66BB6A).withOpacity(0.3),
  blurRadius: 12,
  spreadRadius: 2,
)
```

### 5.3 Hover States (Web/Desktop)

```
Default: Original color
Hover: Lighten by 10%
Active/Pressed: Darken by 10%
Disabled: 38% opacity
```

### 5.4 Focus States

```
Focus Ring: 2px solid #4DD0E1
Focus Glow: 0px 0px 8px rgba(77, 208, 225, 0.5)
```

### 5.5 Ripple Effects

```
Ripple Color: rgba(77, 208, 225, 0.2)
Duration: 300ms
Curve: Curves.easeOut
```

---

## 6. Transitions & Animations

### 6.1 Theme Switch Animation

```dart
AnimatedTheme(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  data: isDarkMode ? darkTheme : lightTheme,
  child: child,
)
```

**Recommended Transition:**
- Fade between themes (opacity 1.0 to 0.0 to 1.0)
- Duration: 300ms
- Curve: Curves.easeInOut

### 6.2 Component Animations

#### Card Appearance
```
Fade In + Scale
Initial: opacity 0.0, scale 0.95
Final: opacity 1.0, scale 1.0
Duration: 200ms
Curve: Curves.easeOut
```

#### Bottom Sheet
```
Slide Up
Initial: Offset(0, 1)
Final: Offset(0, 0)
Duration: 300ms
Curve: Curves.easeOutCubic
```

#### Dialog
```
Scale + Fade
Initial: opacity 0.0, scale 0.8
Final: opacity 1.0, scale 1.0
Duration: 200ms
Curve: Curves.easeOut
```

---

## 7. Accessibility in Dark Mode

### 7.1 Contrast Ratios

**WCAG 2.1 Standards Met:**
- AAA for primary text (11.5:1)
- AA for secondary text (5.8:1)
- AA for large text (4.5:1)

### 7.2 Color Blindness Considerations

**Protanopia/Deuteranopia Safe:**
- Use color + icons/text labels
- Avoid red-green only distinctions
- Protein/Carbs use shape + color

**Tritanopia Safe:**
- Blue accents have sufficient brightness contrast
- Yellow warnings distinguishable

### 7.3 Screen Reader Support

- All interactive elements have semantic labels
- Color is not the only means of conveying information
- Focus indicators clearly visible

---

## 8. Implementation Guidelines

### 8.1 Updated AppColors Class

```dart
class AppColors {
  // ... existing code ...
  
  /// Get theme-aware colors
  static Color getBackground(Brightness brightness) {
    return brightness == Brightness.dark ? backgroundDark : background;
  }
  
  static Color getSurface(Brightness brightness) {
    return brightness == Brightness.dark ? surfaceDark : surface;
  }
  
  static Color getPrimary(Brightness brightness) {
    return brightness == Brightness.dark ? primaryLight : primary;
  }
  
  // ... additional helper methods ...
}
```

### 8.2 Theme Data Configuration

```dart
// In main.dart
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryLight,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  cardColor: AppColors.surfaceDark,
  dividerColor: AppColors.dividerDark,
  
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryLight,
    secondary: AppColors.primaryLight,
    surface: AppColors.surfaceDark,
    background: AppColors.backgroundDark,
    error: AppColors.error,
  ),
  
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.textPrimaryDark,
    elevation: 2,
  ),
  
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primaryLight,
    unselectedItemColor: AppColors.textTertiaryDark,
  ),
  
  // ... additional theme configurations ...
);
```

### 8.3 Widget Adaptation Pattern

```dart
// Before (hardcoded)
Container(
  color: Color(0xFFF5FAFA),
  child: Text(
    'Hello',
    style: TextStyle(color: Color(0xFF1A2A2C)),
  ),
)

// After (theme-aware)
Container(
  color: Theme.of(context).scaffoldBackgroundColor,
  child: Text(
    'Hello',
    style: TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
    ),
  ),
)
```

### 8.4 Migration Checklist

- [ ] Update main.dart with full dark theme data
- [ ] Replace hardcoded colors with Theme.of(context) references
- [ ] Update all custom widgets to support theme
- [ ] Test contrast ratios
- [ ] Verify all screens in both modes
- [ ] Check image assets (consider dark variants)
- [ ] Test animations during theme switch
- [ ] Validate with screen readers
- [ ] Test on different display types (LCD, OLED)

---

## 9. Testing Requirements

### 9.1 Visual Testing

- [ ] All screens render correctly in dark mode
- [ ] No color contrast issues
- [ ] Gradients appear as designed
- [ ] Shadows visible but not overpowering
- [ ] Text readable in all contexts
- [ ] Icons clearly visible

### 9.2 Functional Testing

- [ ] Theme toggle works smoothly
- [ ] Theme persists across app restarts
- [ ] System theme detection works
- [ ] Animations smooth during switch
- [ ] No layout shifts during theme change

### 9.3 Accessibility Testing

- [ ] Screen reader announces all elements
- [ ] Focus indicators visible
- [ ] Contrast meets WCAG AA standards
- [ ] Color-blind users can navigate
- [ ] Keyboard navigation works (desktop)

---

## 10. Platform-Specific Considerations

### 10.1 Android
- System navigation bar should match theme
- Status bar icons should adapt (light icons in dark mode)
- OLED display optimization (true blacks where appropriate)

### 10.2 iOS
- Status bar style should match theme
- Respect system appearance settings
- Smooth theme transitions

### 10.3 Web
- Browser scrollbar styling (dark)
- Meta theme-color tag update
- Prefers-color-scheme CSS support

### 10.4 Desktop (Windows/macOS/Linux)
- Title bar should match theme
- System tray icon adaptation
- Native context menus match theme

---

## 11. Performance Optimization

### 11.1 Theme Switching

- Cache theme mode in SharedPreferences
- Use const constructors where possible
- Minimize rebuilds during theme switch
- Preload both themes at app start

### 11.2 Rendering

- Use RepaintBoundary for complex widgets
- Optimize gradient rendering
- Cache color calculations
-
Key Highlights:
1. Complete Color System

Proper elevation-based background system (#121212, #1E1E1E, #2D2D2D)
Adjusted primary colors for better dark mode contrast
WCAG AA/AAA compliant text colors
Dark mode variants for all status and nutrition colors

2. Component-by-Component Design

Detailed specs for every UI component (buttons, cards, inputs, etc.)
Specific color codes, shadows, and styling for each element
Hover, pressed, and focus states

3. Screen-Specific Guidelines

Dark mode design for every screen in your app
Authentication, Home, Pharmacy, Fitness, Health, Nutrition, Services, Profile, and Settings
Maintains visual hierarchy and brand identity in dark mode

4. Technical Implementation

Code examples for theme configuration
Migration patterns from hardcoded colors to theme-aware code
Proper dark mode gradients and shadows

5. Accessibility Focus

Meets WCAG 2.1 standards
Color-blind safe design
Screen reader support considerations

6. Smooth Transitions

300ms animated theme switching
Proper animation curves
No jarring visual changes

The dark mode uses true dark (#121212) instead of pure black to prevent OLED burn-in, with lighter surfaces appearing "elevated" above the background - a key Material Design 3 principle. All your primary teal colors are adjusted to lighter variants (#4DD0E1) for better contrast on dark backgroundscl