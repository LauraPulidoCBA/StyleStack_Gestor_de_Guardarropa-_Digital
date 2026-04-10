import 'package:flutter/material.dart';

class OutfitWidget extends StatelessWidget {
    const OutfitWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.black,
      child: Center(
        child: Text(
          "Outfit sugerido",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}