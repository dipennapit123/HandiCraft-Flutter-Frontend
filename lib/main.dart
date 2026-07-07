import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:handicraftmobilefrontend/controllers/cart_controller.dart';
import 'package:handicraftmobilefrontend/view/cartScreen_view.dart';
import 'package:handicraftmobilefrontend/view/checkout_view.dart';
import 'package:handicraftmobilefrontend/view/main_layout.dart';

void main() {
  // Register CartController once, before any screen calls Get.find<CartController>()
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KalaKosh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: CheckoutScreen(),
    );
  }
}
