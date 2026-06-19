/// Represents error codes that may occur while fetching call logs.
abstract final class CallLogErrorCode {
  /// Represents an error code indicating that the app does not have permission to access call logs.
  static const permissionDenied = 'PERMISSION_DENIED';
  /// Represents an error code indicating that the provided date range is invalid.
  static const invalidDateRange = 'INVALID_DATE_RANGE';
  /// Represents an error code indicating that a platform-specific error occurred.
  static const platformError = 'PLATFORM_ERROR';
  /// Represents an error code indicating that an unknown error occurred.
  static const unknownError = 'UNKNOWN_ERROR';
}