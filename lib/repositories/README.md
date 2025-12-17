# Repositories

This folder contains repository interfaces for future Firebase integration.

## Current Status

⚠️ **These files are placeholders for future Firebase integration and are NOT currently used.**

The app currently uses SQLite via `DatabaseHelper` for all data operations. These repository files are prepared for when Firebase backend integration is needed.

## Files

- `activity_repository.dart` - Future Firebase implementation for activity tracking
- `appointment_repository.dart` - Future Firebase implementation for appointments
- `clinic_repository.dart` - Future Firebase implementation for clinic services
- Other repository files - Prepared for Firebase migration

## Usage

These files will be used when:
1. Firebase dependencies are added to `pubspec.yaml`
2. Backend migration from SQLite to Firebase is implemented
3. Cloud sync functionality is needed

Until then, all data operations use `lib/database/database_helper.dart` with SQLite.

