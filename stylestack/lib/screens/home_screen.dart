import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StyleStack")),
      body: Center(
        child: Text("Bienvenida a StyleStack"),
      ),
    );
  }
}