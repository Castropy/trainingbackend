import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/cancion.dart';
import '../services/api_service.dart';

class CancionNotifier extends StateNotifier<List<Cancion>> {
  final ApiService api;

  CancionNotifier(this.api) : super([]);

  Future<void> loadCanciones() async {
    final canciones = await api.getCanciones();
    state = canciones;
  }

  Future<void> addCancion(Cancion nueva) async {
    final creada = await api.addCancion(nueva);
    state = [...state, creada]; // 👈 actualiza lista en memoria
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: 'http://10.0.2.2:8000/api/canciones/');
});

final cancionesProvider =
    StateNotifierProvider<CancionNotifier, List<Cancion>>((ref) {
  final api = ref.watch(apiServiceProvider);
  return CancionNotifier(api);
});
