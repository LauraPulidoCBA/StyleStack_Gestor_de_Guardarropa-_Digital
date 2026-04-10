import 'package:flutter/material.dart';

class OutfitWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.black,
      child: Center(
        child: Text(
          "Outfit sugerido 👕👖",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}