import 'package:permission_handler/permission_handler.dart';
/// A service class to handle call log permissions.
class CallLogPermissionService {
  /// Ensures that the app has the necessary permission to access call logs.
  static Future<bool> ensurePermission() async {
    final status = await Permission.phone.status;

    if (status.isGranted) return true;

    final result = await Permission.phone.request();

    return result.isGranted;
  }
}