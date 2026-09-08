// lib/main.dart
//
// Starting point of the app. Flutter runs main() first.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/controllers/cart_controller.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_strings.dart';
import 'package:handicraftmobilefrontend/view/main_layout.dart';

void main() {
  // Register CartController once, before any screen calls Get.find<CartController>()
  Get.put(CartController());
  runApp(const MyApp());
}

/// The root widget. It sets the app title, the theme and the first screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp, not MaterialApp, because the cart and checkout screens
    // move around with Get.to() and show messages with Get.snackbar().
    // Those calls only work inside a GetMaterialApp.
    return GetMaterialApp(
      title: AppStrings.appTitle,
      // Hides the "DEBUG" ribbon in the corner.
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Flutter builds a full colour set from our main brand colour.
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      // First screen the user sees.
      home: const MainLayoutView(),
    );
  }
}
