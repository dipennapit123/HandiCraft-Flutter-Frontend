// lib/utils/api_constants.dart
//
// ONE place for the backend address.
// Every feature (shop, categories, cart, wishlist, auth) should import this
// file and only add its own route, for example:
//
//   ApiConstants.baseUrl + '/products'
//   ApiConstants.baseUrl + '/categories'
//   ApiClient.dio.get('/products')   // Dio already has baseUrl set
//
// Do NOT put the server URL in AppStrings, views, or controllers.

class ApiConstants {
  /// Server host only (no /api).
  /// Use this for images: ApiConstants.serverUrl + '/images/pot.jpg'
  static const String _defaultServerUrl =
      'https://kalakosh-e-commerce-platform.onrender.com';

  /// Optional override when running the backend on your own machine:
  ///
  ///   flutter run --dart-define=API_BASE_URL=http://localhost:5000/api
  ///
  /// On the Android emulator use http://10.0.2.2:5000/api instead of localhost.
  static const String _customBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Full API root, example:
  /// https://kalakosh-e-commerce-platform.onrender.com/api
  ///
  /// All routes start from here:
  ///   /products, /categories, /cart, /wishlist, /auth/...
  static String get baseUrl {
    if (_customBaseUrl.isNotEmpty) {
      return _stripTrailingSlash(_customBaseUrl);
    }
    return '$_defaultServerUrl/api';
  }

  /// Server address without "/api".
  /// Built from [baseUrl] so a custom override still works for images.
  static String get serverUrl {
    String url = baseUrl;

    if (url.endsWith('/api')) {
      url = url.substring(0, url.length - 4);
    } else if (url.endsWith('/api/')) {
      url = url.substring(0, url.length - 5);
    }

    return url;
  }

  // Render's free plan sleeps when idle and can take up to a minute to wake.
  static const Duration connectTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);

  static String _stripTrailingSlash(String url) {
    if (url.endsWith('/')) {
      return url.substring(0, url.length - 1);
    }
    return url;
  }
}
