import 'package:call_log_fetcher/call_log_fetcher_method_channel.dart';
import 'package:call_log_fetcher/model/call_log_entry.dart';
import 'package:call_log_fetcher/model/call_log_query.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class CallLogFetcherPlatform extends PlatformInterface {
  CallLogFetcherPlatform() : super(token: _token);

  static final Object _token = Object();

  static CallLogFetcherPlatform _instance = MethodChannelCallLogFetcher();

  static CallLogFetcherPlatform get instance => _instance;

  static set instance(CallLogFetcherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<CallLogEntry>> query(CallLogQuery query);
}
