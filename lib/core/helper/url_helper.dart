import 'package:school_system/core/utils/app_constants.dart';

class UrlHelper {
  static String getFullImageUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';

    String result = url.trim();

    // لو الرابط نسبي
    if (result.startsWith('/')) {
      result = '${AppConstants.apiBaseUrl}$result';
    }

    // لو فيه localhost → Emulator fix
    result = result.replaceAll('localhost', '10.0.2.2');

    return result;
  }
}
