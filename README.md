# call_log_fetcher

A Flutter plugin for fetching Android call logs within a specified date range.

This plugin is designed primarily for **enterprise and internal applications**.

## Intended Use

Typical use cases include:

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

This plugin requires access to Android call logs through the `READ_CALL_LOG` permission.

Access to call logs is considered sensitive and may be restricted by app distribution platforms such as Google Play.

Developers using this plugin are responsible for ensuring compliance with:

* Google Play policies
* Local privacy regulations
* User consent requirements
* Applicable laws and regulations

## Features

* Fetch call logs within a specified date range
* Flutter-based permission handling
* Typed Dart models
* Structured exception handling
* Native Android querying for efficient filtering

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  call_log_fetcher: ^0.1.0
```

Then run:

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

## Data Models

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

The plugin throws `CallLogException` for expected failures.

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

## Architecture

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
* Intended for enterprise and internal applications
* Requires `READ_CALL_LOG` permission
* OEM implementations may vary
* Access to call logs may be restricted by Google Play policies
* No background synchronization
* No pagination
* No streaming support

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

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
