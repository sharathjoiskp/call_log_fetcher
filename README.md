# call_log_fetcher

A Flutter plugin for fetching Android call logs within a specified date range.

This plugin is designed primarily for **enterprise and internal applications**, such as:

* CRM synchronization
* Field sales tracking
* Logistics communication tracking
* Operational analytics

## Platform Support

| Platform | Supported |
| -------- | --------- |
| Android  | ✅         |
| iOS      | ❌         |

## Important Notice

This plugin requires the `READ_CALL_LOG` permission.

Access to Android call logs is considered sensitive and may be restricted by distribution platforms such as Google Play.

Before using this plugin, ensure that your application complies with all applicable platform policies and legal requirements.

Developers are solely responsible for:

* Obtaining user consent where required
* Complying with Google Play policies
* Complying with local privacy regulations
* Ensuring appropriate use of call log data

## Features

* Fetch call logs within a specified date range
* Explicit permission handling in Flutter
* Typed Dart models
* Structured exception handling
* Android-native querying for efficient filtering

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  call_log_fetcher: ^0.0.1
```

Run:

```bash
flutter pub get
```

## Android Configuration

Add the following permission to your application's `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_CALL_LOG" />
```

File location:

```text
android/app/src/main/AndroidManifest.xml
```

## Usage

Import the package:

```dart
import 'package:call_log_fetcher/call_log_fetcher.dart';
```

Fetch call logs:

```dart
try {
  final logs = await CallLogFetcher().getCallLog(
    CallLogQuery(
      from: DateTime.now().subtract(const Duration(days: 1)),
      to: DateTime.now(),
    ),
  );

  for (final log in logs) {
    debugPrint(
      '${log.number} - ${log.callType} - ${log.duration.inSeconds}s',
    );
  }
} on CallLogException catch (e) {
  debugPrint('${e.code}: ${e.message}');
}
```

## Data Model

### CallLogQuery

| Property | Type     | Description              |
| -------- | -------- | ------------------------ |
| from     | DateTime | Start of the query range |
| to       | DateTime | End of the query range   |

### CallLogEntry

| Property | Type     | Description              |
| -------- | -------- | ------------------------ |
| number   | String   | Phone number             |
| callType | CallType | Call direction or status |
| date     | DateTime | Call timestamp           |
| duration | Duration | Call duration            |

### CallType

Supported values:

* `CallType.incoming`
* `CallType.outgoing`
* `CallType.missed`
* `CallType.unknown`

## Error Handling

The plugin throws `CallLogException` for all expected failures.

Example:

```dart
try {
  final logs = await CallLogFetcher().getCallLog(query);
} on CallLogException catch (e) {
  switch (e.code) {
    case 'PERMISSION_DENIED':
      // Handle permission denial
      break;

    case 'INVALID_DATE_RANGE':
      // Handle invalid date range
      break;

    default:
      // Handle other errors
      break;
  }
}
```

### Error Codes

| Code                 | Description                                |
| -------------------- | ------------------------------------------ |
| `PERMISSION_DENIED`  | User denied call log permission            |
| `INVALID_DATE_RANGE` | The `from` date occurs after the `to` date |
| `UNKNOWN_ERROR`      | Unexpected error                           |

## How It Works

Responsibilities are intentionally separated:

### Flutter Layer

* Permission handling
* Input validation
* Data mapping
* Error handling

### Native Android Layer

* Querying Android call logs
* Filtering by date range
* Returning raw data to Flutter

## Limitations

* Android only
* No background synchronization
* No pagination
* No streaming support
* OEM implementations may vary

## Example Application

A complete example application is included in the `example/` directory.

Run it using:

```bash
cd example
flutter pub get
flutter run
```

## Contributing

Issues and pull requests are welcome.
