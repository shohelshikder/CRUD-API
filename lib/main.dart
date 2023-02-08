import 'package:crud_api/Screen/productGridViewScreen.dart';
import 'package:crud_api/Screen/product_create_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductGridViewScreen(),
    );
  }
}
