import 'package:call_log_fetcher/model/call_log_entry.dart';
import 'package:call_log_fetcher/model/call_log_query.dart';
import 'package:call_log_fetcher/permission_handler.dart';

import 'call_log_fetcher_platform_interface.dart';

class CallLogFetcher {
   static Future<List<CallLogEntry>> getCallLog(CallLogQuery query) async {
    if (!query.from.isBefore(query.to)) {
      throw const CallLogException(
        'INVALID_DATE_RANGE',
        'from must be earlier than to',
      );
    }

    final hasPermission = await CallLogPermissionService.ensurePermission();

    if (!hasPermission) {
      throw const CallLogException(
        'PERMISSION_DENIED',
        'Call log permission not granted',
      );
    }

    return CallLogFetcherPlatform.instance.query(query);
  }
}

class CallLogException implements Exception {
  final String code;
  final String message;

  const CallLogException(this.code, this.message);

  @override
  String toString() => 'CallLogException($code, $message)';
}
