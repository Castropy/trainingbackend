class Cancion {
  final int? id;
  final String nombre;
  final String duracion;
  final String artista;
  final String album;

  Cancion({this.id, required this.nombre, required this.duracion, required this.artista, required this.album});

  factory Cancion.fromJson(Map<String, dynamic> json) {
    return Cancion(
      id: json['id'],
      nombre: json['nombre'],
      duracion: json['duracion'],
      artista: json['artista'],
      album: json['album'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'duracion': duracion,
      'artista': artista,
      'album': album,
    };
  }
}
