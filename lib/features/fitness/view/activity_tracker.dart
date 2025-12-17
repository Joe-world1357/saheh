// This file redirects to the new ActivityTrackerScreen with real data
export 'activity_tracker_screen.dart' show ActivityTrackerScreen;

import 'package:flutter/material.dart';
import 'activity_tracker_screen.dart';

/// Legacy ActivityTracker - redirects to new screen with real data
class ActivityTracker extends StatelessWidget {
  const ActivityTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const ActivityTrackerScreen();
  }
}
