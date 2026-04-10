import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wardrobe_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WardrobeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return const MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}