import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape:StadiumBorder(),
      onPressed: onPressed,
      child: const Icon(Icons.save),
    );
  }
}
