import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cancion.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api/canciones/";
 
  // ⚠️ Usa 10.0.2.2 si estás en emulador Android.
  // Si usas dispositivo físico, reemplaza por la IP local de tu PC.

  Future<Cancion> addCancion(Cancion cancion) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cancion.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Cancion(
        nombre: data["nombre"],
        duracion: data["duracion"],
        artista: data["artista"],
        album: data["album"],
      );
    } else {
      throw Exception("Error al registrar canción: ${response.body}");
    }
  }

  Future<List<Cancion>> getCanciones() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Cancion(
        nombre: json["nombre"],
        duracion: json["duracion"],
        artista: json["artista"],
        album: json["album"],
      )).toList();
    } else {
      throw Exception("Error al obtener canciones");
    }
  }
}
