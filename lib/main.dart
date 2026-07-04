import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/view/MainLayout.dart';
import 'package:handicraftmobilefrontend/view/ProductDetailView.dart';
import 'package:handicraftmobilefrontend/view/ShopView.dart';

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

