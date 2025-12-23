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

  void _guardarCancion() {
    if (_formKey.currentState!.validate()) {
      final nuevaCancion = Cancion(
        nombre: nombreController.text,
        duracion: duracionController.text,
        artista: artistaController.text,
        album: albumController.text,
      );

      // Guardamos en el provider
      ref.read(cancionProvider.notifier).state = nuevaCancion;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Canción registrada en estado global")),
      );

      //print("Canción guardada: ${nuevaCancion.toJson()}");
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
              CustomTextFormFields(controller: duracionController, label: "Duración"),
              CustomTextFormFields(controller: artistaController, label: "Artista"),
              CustomTextFormFields(controller: albumController, label: "Álbum"),
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
