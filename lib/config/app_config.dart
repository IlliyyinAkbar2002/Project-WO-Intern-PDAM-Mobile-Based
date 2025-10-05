import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_intern_pdam/core/utils/debug_log.dart';

class AppConfig {
  static final String environment = dotenv.env['ENVIRONMENT'] ?? 'development';
  static final String backendDomain = dotenv.env['BACKEND_DOMAIN']!;
  static final String baseStorageUrl =
      dotenv.env['BACKEND_URL'] ?? '$backendDomain/storage/app/public/';

  static Map<String, dynamic> toMap() {
    return {'environment': environment};
  }

  static String toJson() {
    return jsonEncode(toMap());
  }

  static void logConfig() {
    DebugLog.info(message: "AppConfig: ${toJson()}");
  }
}
