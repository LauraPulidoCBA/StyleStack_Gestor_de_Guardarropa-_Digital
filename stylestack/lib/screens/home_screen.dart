import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wardrobe = Provider.of<WardrobeProvider>(context);

    
    return Scaffold(
      appBar: AppBar(title: Text("StyleStack")),
      body: ListView.builder(
  itemCount: wardrobe.clothes.length,
  itemBuilder: (context, index) {
    final item = wardrobe.clothes[index];

    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.category),
    );
  },
),
    );
  }
}