/// Represents the type of a call log entry.
enum CallType {
  /// Represents an incoming call.
  incoming,
  /// Represents an outgoing call.
  outgoing,
  /// Represents a missed call.
  missed,
  /// Represents an unknown call type.
  unknown,
}
    /// A class that represents a single call log entry.
class CallLogEntry {
  final String number;
  final CallType callType;
  final DateTime date;
  final Duration duration;
/// Creates a new instance of [CallLogEntry] with the given parameters.
  CallLogEntry({
    required this.number,
    required this.callType,
    required this.date,
    required this.duration,
  });
/// Creates a new instance of [CallLogEntry] from a map.
  factory CallLogEntry.fromMap(Map<dynamic, dynamic> map) {
    return CallLogEntry(
      number: map['number'] ?? '',
      callType: _mapType(map['callType']),
      date: DateTime.fromMillisecondsSinceEpoch(map['calledDate']),
      duration: Duration(seconds: map['duration'] ?? 0),
    );
  }

  static CallType _mapType(String? type) {
    switch (type) {
      case 'Incoming':
        return CallType.incoming;
      case 'Outgoing':
        return CallType.outgoing;
      case 'Missed':
        return CallType.missed;
      default:
        return CallType.unknown;
    }
  }
}