// lib/widgets/status_view.dart
//
// Three tiny widgets we show while the API call is happening:
//   LoadingView  -> spinner
//   ErrorView    -> message + retry button
//   EmptyView    -> "nothing found" message
//
// Keeping them here means the screens stay short and easy to read.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';

/// Spinner shown while we wait for the backend.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 80),
      child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}

/// Error message with a "Try again" button.
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        children: [
          const Icon(Icons.wifi_off, color: AppColors.secondary, size: 40),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.secondary,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: onRetry,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}

/// Message shown when the API returned zero products.
class EmptyView extends StatelessWidget {
  final String message;

  const EmptyView({super.key, this.message = 'No products found'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: AppColors.secondary,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
