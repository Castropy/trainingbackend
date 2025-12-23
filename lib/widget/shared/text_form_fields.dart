import 'package:flutter/material.dart';

class CustomTextFormFields extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomTextFormFields({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: 
       InputDecoration(labelText: label),
       
       
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
    );
  }
}
