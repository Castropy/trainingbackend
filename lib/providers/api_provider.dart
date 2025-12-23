import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/cancion.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final cancionesProvider = FutureProvider<List<Cancion>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.getCanciones();
});
