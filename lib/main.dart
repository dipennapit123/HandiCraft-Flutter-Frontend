import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/view/main_layout.dart';
import 'package:handicraftmobilefrontend/view/ShopView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KalaKosh',
      theme: ThemeData(
    
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  MainLayoutView(),
    );
  }
}

