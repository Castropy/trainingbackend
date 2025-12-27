import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cancion.dart';

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  Future<Cancion> addCancion(Cancion cancion) async {
    final response = await _client.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cancion.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Cancion.fromJson(data);
    } else {
      throw Exception("Error al registrar canción: ${response.body}");
    }
  }

  Future<List<Cancion>> getCanciones() async {
    final response = await _client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Cancion.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener canciones");
    }
  }
}
