import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

/// Permission Handler for Android 13+ Notification Permissions
class PermissionHandler {
  PermissionHandler._();

  /// Request notification permission (Android 13+)
  /// Returns true if granted, false otherwise
  static Future<bool> requestNotificationPermission() async {
    if (!Platform.isAndroid) {
      return true; // iOS handled by system
    }

    try {
      // Check Android version
      if (Platform.isAndroid) {
        // Android 13+ (API 33+) requires runtime permission
        final status = await ph.Permission.notification.request();
        
        if (status.isGranted) {
          debugPrint('Notification permission granted');
          return true;
        } else if (status.isPermanentlyDenied) {
          debugPrint('Notification permission permanently denied');
          // User can enable in settings
          return false;
        } else {
          debugPrint('Notification permission denied');
          return false;
        }
      }

      return true;
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
      return false;
    }
  }

  /// Check if notification permission is granted
  static Future<bool> checkNotificationPermission() async {
    if (!Platform.isAndroid) {
      return true; // iOS handled by system
    }

    try {
      final status = await ph.Permission.notification.status;
      return status.isGranted;
    } catch (e) {
      debugPrint('Error checking notification permission: $e');
      return false;
    }
  }

  /// Open app settings (if permission is permanently denied)
  static Future<bool> openAppSettings() async {
    try {
      return await ph.openAppSettings();
    } catch (e) {
      debugPrint('Error opening app settings: $e');
      return false;
    }
  }
}

