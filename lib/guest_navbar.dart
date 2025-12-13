import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'pharmacy_screen.dart';
import 'fitness_dashboard.dart';
import 'profile_screen.dart';
import 'services_screen.dart';

class GuestNavbar
    extends
        StatefulWidget {
  const GuestNavbar({
    super.key,
  });

  @override
  State<
    GuestNavbar
  >
  createState() => _GuestNavbarState();
}

class _GuestNavbarState
    extends
        State<
          GuestNavbar
        > {
  int _selectedIndex = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );

    final List<
      Widget
    >
    screens = [
      const HomeScreen(), // Tab 0: Home
      const PharmacyScreen(), // Tab 1: Pharmacy
      const FitnessDashboard(), // Tab 2: Fitness
      const ServicesScreen(), // Tab 3: Services
      const ProfileScreen(), // Tab 4: Profile
    ];

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primary,
        unselectedItemColor: const Color(
          0xFF687779,
        ),
        onTap:
            (
              index,
            ) => setState(
              () => _selectedIndex = index,
            ),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_pharmacy_outlined,
            ),
            activeIcon: Icon(
              Icons.local_pharmacy,
            ),
            label: 'Pharmacy',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center_outlined,
            ),
            activeIcon: Icon(
              Icons.fitness_center,
            ),
            label: 'Fitness',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_view_outlined,
            ),
            activeIcon: Icon(
              Icons.grid_view,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            activeIcon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
