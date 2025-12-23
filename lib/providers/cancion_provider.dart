import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cancion.dart';
import '../services/api_service.dart';
import '../repositories/cancion_repository.dart';

// Provider para una canción puntual (última creada)
final cancionProvider = StateProvider<Cancion?>((ref) => null);

// Provider para el servicio API
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: 'http://10.0.2.2:8000/api/canciones/');
});

// Provider para el repositorio
final cancionRepositoryProvider = Provider<CancionRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  return CancionRepository(api);
});

// Provider para obtener todas las canciones (GET)
final cancionesFutureProvider = FutureProvider<List<Cancion>>((ref) {
  final repo = ref.watch(cancionRepositoryProvider);
  return repo.getAll();
});
