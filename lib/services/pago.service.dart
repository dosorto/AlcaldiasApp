import 'package:alcaldias/constants.dart';
import 'package:alcaldias/models/data.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Data> fetchPagosPendientes(String token) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.parse(API_URL + "/user/pagos-pendientes"),
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

Future<Data> fetchPagosRealizados(String token) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.parse(API_URL + "/user/pagos-realizados"),
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
