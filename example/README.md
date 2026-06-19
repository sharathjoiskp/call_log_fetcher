# Call Log Fetcher Example

This example demonstrates how to use the `call_log_fetcher` plugin to retrieve Android call logs within a specified date range.

## Prerequisites

* Android device or emulator
* Android SDK configured
* Flutter installed

> iOS is not supported.

## Required Permission

The example app declares the following permission:

```xml
<uses-permission android:name="android.permission.READ_CALL_LOG" />
```

When the app runs, the plugin requests permission at runtime before fetching call logs.

## Running the Example

From the root of the plugin repository:

```bash
cd example
flutter pub get
flutter run
```

## Example Usage

```dart
final logs = await CallLogFetcher().getCallLog(
  CallLogQuery(
    from: DateTime.now().subtract(const Duration(days: 1)),
    to: DateTime.now(),
  ),
);
```

## Error Handling

```dart
try {
  final logs = await CallLogFetcher().getCallLog(
    CallLogQuery(
      from: DateTime.now().subtract(const Duration(days: 1)),
      to: DateTime.now(),
    ),
  );
} on CallLogException catch (e) {
  debugPrint('${e.code}: ${e.message}');
}
```

## Important Notes

* Android only
* Requires `READ_CALL_LOG` permission
* OEM implementations may vary
* Access to call logs may be restricted by Google Play policies
* Developers are responsible for ensuring compliance with applicable platform policies
