import 'package:permission_handler/permission_handler.dart';

class CallLogPermissionService {
  static Future<bool> ensurePermission() async {
    final status = await Permission.phone.status;

    if (status.isGranted) return true;

    final result = await Permission.phone.request();

    return result.isGranted;
  }
}