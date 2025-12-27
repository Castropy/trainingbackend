import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_backend/models/cancion.dart';
import 'package:training_backend/providers/cancion_provider.dart';
import 'package:training_backend/widget/shared/floating_action_buttons.dart';
import 'package:training_backend/widget/shared/text_form_fields.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final duracionController = TextEditingController();
  final artistaController = TextEditingController();
  final albumController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    duracionController.dispose();
    artistaController.dispose();
    albumController.dispose();
    super.dispose();
  }

  void _guardarCancion() async {
    if (_formKey.currentState!.validate()) {
      final nuevaCancion = Cancion(
        nombre: nombreController.text,
        duracion: duracionController.text,
        artista: artistaController.text,
        album: albumController.text,
      );

      try {
        // 👇 Usamos el StateNotifier para agregar y actualizar la lista global
        final cancionesNotifier = ref.read(cancionesProvider.notifier);
        await cancionesNotifier.addCancion(nuevaCancion);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Conexión OK: ${nuevaCancion.nombre} guardada en backend")),
        );

        // Limpiar campos
        nombreController.clear();
        duracionController.clear();
        artistaController.clear();
        albumController.clear();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Error de conexión: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final canciones = ref.watch(cancionesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Canción')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormFields(controller: nombreController, label: "Nombre"),
              const SizedBox(height: 10),
              CustomTextFormFields(controller: duracionController, label: "Duración"),
              const SizedBox(height: 10),
              CustomTextFormFields(controller: artistaController, label: "Artista"),
              const SizedBox(height: 10),
              CustomTextFormFields(controller: albumController, label: "Álbum"),
              const SizedBox(height: 20),
              CustomFAB(onPressed: _guardarCancion),
              if (canciones.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text("Última canción registrada: ${canciones.last.nombre} - ${canciones.last.artista}"),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
