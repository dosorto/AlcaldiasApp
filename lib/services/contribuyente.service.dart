// contribuyente_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alcaldias/models/data.model.dart';
import 'package:alcaldias/constants.dart'; // Asegúrate de que este archivo tiene la constante API_URL

Future<Data> fetchContribuyente(String token) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.parse(API_URL + "/contribuyente"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('Authorization: Bearer $token');
    print(response.body);
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return Data(
      code: response.statusCode,
      message: decodedResponse["message"] ?? "",
      data: decodedResponse["data"],
    );
  } finally {
    client.close();
  }
}
