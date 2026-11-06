import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(const GroceryApp());

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Groceries',
      theme: ThemeData(primarySwatch: Colors.green, scaffoldBackgroundColor: Colors.white),
      home: const HomeScreen());
}