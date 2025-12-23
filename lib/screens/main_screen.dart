import 'package:flutter/material.dart';
import 'package:training_backend/widget/text_form_fields.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),

      body: Center(
        child: CustomTextFormFields(),
      ),
    );
  }
}