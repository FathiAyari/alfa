import 'package:flutter/material.dart';

class Facture extends StatelessWidget {
  const Facture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png', // Replace with your own image file path
          fit: BoxFit.cover, // Make sure the image covers the entire screen
        ),
      ),
    );
  }
}
