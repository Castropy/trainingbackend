import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_backend/screens/home_screen.dart';
import 'package:training_backend/theme/app_theme.dart';


void main() {
  runApp(const ProviderScope(child: MyApp())); // 👈 Aquí envolvemos la app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Training Backend',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
