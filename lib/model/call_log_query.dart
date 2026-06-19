
/// Represents a query for fetching call logs within a specific date range.
class CallLogQuery {
  /// The start date of the query range.
  final DateTime from;
  /// The end date of the query range.
  final DateTime to;
/// Creates a new instance of [CallLogQuery] with the given [from] and [to] dates.
  const CallLogQuery({required this.from, required this.to});
  /// Converts the [CallLogQuery] instance to a map representation.
  Map<String, dynamic> toMap() {
    return {
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
    };
  }
}
