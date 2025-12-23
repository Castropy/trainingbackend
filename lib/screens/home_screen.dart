import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_backend/providers/navigation_provider.dart';
import 'package:training_backend/screens/main_screen.dart';
import 'package:training_backend/screens/saved_form_screens.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navigationIndexProvider);

    final screens = [
      const MainScreen(),
      const SavedFormScreens(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Training Backend")),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: const Text("Ricardo Dev"),
        accountEmail: const Text("ricardo@example.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 40, color: Colors.blue),
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.add, color: Colors.blue),
        title: const Text("Registrar Canción"),
        onTap: () {
          ref.read(navigationIndexProvider.notifier).state = 0;
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.library_music, color: Colors.blue),
        title: const Text("Canciones Guardadas"),
        onTap: () {
          ref.read(navigationIndexProvider.notifier).state = 1;
          Navigator.pop(context);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.settings, color: Colors.grey),
        title: const Text("Configuración"),
        onTap: () {
          // Aquí podrías agregar otra pantalla
        },
      ),
    ],
  ),
),

      body: screens[index],
    );
  }
}
