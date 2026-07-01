import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:handicraftmobilefrontend/views/browse_categories_view.dart'; 

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BrowseCategoriesView(), 
    );
  }
}