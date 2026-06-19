class CallLogQuery {
  final DateTime from;
  final DateTime to;

  const CallLogQuery({required this.from, required this.to});

  Map<String, dynamic> toMap() {
    return {
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
    };
  }
}
