enum CallType {
  incoming,
  outgoing,
  missed,
  unknown,
}

class CallLogEntry {
  final String number;
  final CallType callType;
  final DateTime date;
  final Duration duration;

  CallLogEntry({
    required this.number,
    required this.callType,
    required this.date,
    required this.duration,
  });

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