class Georeferenciacion {
  final int id;
  final double latitud;
  final double longitud;

  Georeferenciacion({
    required this.id,
    required this.latitud,
    required this.longitud,
  });

  factory Georeferenciacion.fromJson(Map<String, dynamic> json) {
    return Georeferenciacion(
      id: json['id'],
      latitud: double.parse(json['latitud']), // Conversión de String a double
      longitud: double.parse(json['longitud']), // Conversión de String a double
    );
  }
}
