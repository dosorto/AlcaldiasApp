import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alcaldias/constants.dart';
import 'package:alcaldias/models/data.model.dart';

Future<Data> sendPasswordResetEmail(String email) async {
  var client = http.Client();
  try {
    var response = await client.post(
      Uri.parse(API_URL + "/password/email"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );

    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return Data(
      code: response.statusCode,
      message: decodedResponse["message"] ?? "",
      data: decodedResponse,
    );
  } finally {
    client.close();
  }
}
