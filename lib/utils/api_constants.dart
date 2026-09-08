// lib/utils/api_constants.dart
//
// Keeps the backend address in ONE place.
// If the API address changes, we only edit this file.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  // Port where the Node/Express backend runs (npm run dev).
  static const int port = 5000;

  // Optional override when running the app:
  // flutter run --dart-define=API_BASE_URL=http://192.168.1.10:5000/api
  static const String _customBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Full API address, example: http://localhost:5000/api
  static String get baseUrl {
    // 1. Use the custom address if one was given while running the app.
    if (_customBaseUrl.isNotEmpty) {
      return _customBaseUrl;
    }

    // 2. Android emulator cannot use "localhost", it uses 10.0.2.2 instead.
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:$port/api';
    }

    // 3. iOS simulator, macOS and web can use localhost.
    return 'http://localhost:$port/api';
  }

  /// Server address without "/api", example: http://localhost:5000
  /// Used to build full image links when the API returns "/images/pot.jpg".
  static String get serverUrl {
    String url = baseUrl;

    if (url.endsWith('/api')) {
      url = url.substring(0, url.length - 4);
    } else if (url.endsWith('/api/')) {
      url = url.substring(0, url.length - 5);
    }

    return url;
  }

  // How long we wait before showing a connection error.
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
