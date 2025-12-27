import '../models/cancion.dart';
import '../services/api_service.dart';

class CancionRepository {
  final ApiService api;

  CancionRepository(this.api);

  Future<List<Cancion>> getAll() => api.getCanciones();

  Future<Cancion> create(Cancion nueva) => api.addCancion(nueva);
}
