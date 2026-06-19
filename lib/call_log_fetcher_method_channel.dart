import 'package:call_log_fetcher/call_log_fetcher.dart';
import 'package:call_log_fetcher/call_log_fetcher_platform_interface.dart';
import 'package:call_log_fetcher/model/call_log_entry.dart';
import 'package:call_log_fetcher/model/call_log_query.dart';
import 'package:flutter/services.dart';

class MethodChannelCallLogFetcher extends CallLogFetcherPlatform {
  static const MethodChannel _channel = MethodChannel('com.jois.app/platfroms');

  @override
  Future<List<CallLogEntry>> query(CallLogQuery query) async {
    try {
      final result = await _channel.invokeMethod<List<dynamic>>(
        'getCallLogs',
        query.toMap(),
      );

      if (result == null) return [];

      return result.map((e) => CallLogEntry.fromMap(e)).toList();
    } on PlatformException catch (e) {
      throw CallLogException(e.code, e.message ?? 'Platform error');
    } catch (e) {
      throw CallLogException('UNKNOWN_ERROR', e.toString());
    }
  }
}
