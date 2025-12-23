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
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menú de navegación",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Registrar Canción"),
              onTap: () {
                ref.read(navigationIndexProvider.notifier).state = 0;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_music),
              title: const Text("Canciones Guardadas"),
              onTap: () {
                ref.read(navigationIndexProvider.notifier).state = 1;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: screens[index],
    );
  }
}
