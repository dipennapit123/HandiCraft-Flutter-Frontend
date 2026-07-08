import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/view/main_layout.dart';
import 'package:handicraftmobilefrontend/view/product_details_view.dart';
import 'package:handicraftmobilefrontend/view/shop_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KalaKosh',
      theme: ThemeData(
    
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  ProductDetailView(),
    );
  }
}

