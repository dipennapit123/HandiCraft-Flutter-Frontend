// lib/services/api_client.dart
//
// Creates ONE Dio object for the whole app.
// Dio is the package we use to call the backend (HTTP requests).

import 'package:dio/dio.dart';
import 'package:handicraftmobilefrontend/utils/api_constants.dart';

class ApiClient {
  // Private constructor so nobody creates an ApiClient object by mistake.
  ApiClient._();

  /// Shared Dio object. Use it like: ApiClient.dio.get('/products')
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}
