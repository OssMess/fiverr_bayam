import 'package:flutter/material.dart';

class CustomAppBarLogo extends StatelessWidget {
  const CustomAppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_transparent.png',
      fit: BoxFit.contain,
      alignment: Alignment.center,
      height: 50,
    );
  }
}
