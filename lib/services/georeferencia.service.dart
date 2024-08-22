import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alcaldias/models/georeferencia.model.dart';
import 'package:alcaldias/constants.dart'; // Asegúrate de que este archivo tiene la constante API_URL

class GeoreferenciacionService {
  Future<List<Georeferenciacion>> fetchGeoreferenciaciones(
      int propiedadId, String token) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse('$API_URL/user/propiedades/$propiedadId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      if (response.statusCode == 200) {
        List<Georeferenciacion> georeferenciaciones =
            (decodedResponse['data'] as List)
                .map((geoJson) => Georeferenciacion.fromJson(geoJson))
                .toList();
        return georeferenciaciones;
      } else {
        throw Exception(
            'Error al obtener georeferenciaciones: ${decodedResponse["message"]}');
      }
    } finally {
      client.close();
    }
  }
}
