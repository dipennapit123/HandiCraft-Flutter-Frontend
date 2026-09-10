// lib/utils/api_error.dart
//
// Turns a technical Dio error into a short sentence we can show on screen.
// Both the shop screen and the detail screen use this, so it lives in utils.

import 'package:dio/dio.dart';
import 'package:handicraftmobilefrontend/utils/api_constants.dart';

String apiErrorMessage(
  Object error, {
  String fallback = 'Something went wrong',
}) {
  // Errors that Dio did not create (for example a parsing error).
  if (error is! DioException) return fallback;

  // The phone could not reach the server at all.
  final bool cannotConnect =
      error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.connectionTimeout;

  if (cannotConnect) {
    return 'Cannot reach the server.\n'
        'Please check your internet connection and try again.\n\n'
        '(${ApiConstants.baseUrl})';
  }

  // The server answered, but with an error like { "message": "Not found" }.
  final dynamic data = error.response?.data;
  if (data is Map && data['message'] != null) {
    return data['message'].toString();
  }

  return fallback;
}
