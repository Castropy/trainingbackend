import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_backend/providers/cancion_provider.dart';

class SavedFormScreens extends ConsumerWidget {
  const SavedFormScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canciones = ref.watch(cancionesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Canciones guardadas")),
      body: canciones.isEmpty
          ? const Center(child: Text("No hay canciones registradas"))
          : ListView.builder(
              itemCount: canciones.length,
              itemBuilder: (context, index) {
                final c = canciones[index];
                return Card(
                  child: ListTile(
                    title: Text(c.nombre),
                    subtitle: Text("${c.artista} • ${c.album}"),
                    trailing: Text(c.duracion),
                  ),
                );
              },
            ),
    );
  }
}
