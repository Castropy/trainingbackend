import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_backend/models/cancion.dart';
import 'package:training_backend/providers/api_provider.dart';
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
      final api = ref.read(apiServiceProvider);
      final creada = await api.addCancion(nuevaCancion);

      if (!mounted) return; // 👈 aseguramos que el widget sigue activo

      // Guardamos en el provider global
      ref.read(cancionProvider.notifier).state = creada;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Canción registrada: ${creada.nombre}")),
      );

      // Limpia los campos
      nombreController.clear();
      duracionController.clear();
      artistaController.clear();
      albumController.clear();
    } catch (e) {
      if (!mounted) return; // 👈 también aquí
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}



  @override
  Widget build(BuildContext context) {
    final cancion = ref.watch(cancionProvider);

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
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              CustomFAB(onPressed: _guardarCancion),
              if (cancion != null) ...[
                const SizedBox(height: 20),
                Text("Última canción registrada: ${cancion.nombre} - ${cancion.artista}"),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
