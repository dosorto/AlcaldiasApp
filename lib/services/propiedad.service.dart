import 'package:alcaldias/constants.dart';
import 'package:alcaldias/models/data.model.dart';
import 'package:alcaldias/models/propiedad.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Data> fetchPropiedades(String token) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.parse(API_URL + "/user/propiedades"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('Authorization: Bearer $token');
    print(response.body);
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    if (response.statusCode == 200) {
      List<Propiedad> propiedades = (decodedResponse['data'] as List)
          .map((propJson) => Propiedad.fromJson(propJson))
          .toList();
      return Data(
        code: response.statusCode,
        message: decodedResponse["message"] ?? "",
        data: propiedades,
      );
    } else {
      throw Exception(
          'Error al obtener propiedades: ${decodedResponse["message"]}');
    }
  } finally {
    client.close();
  }
}
