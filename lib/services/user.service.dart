import 'package:alcaldias/constants.dart';
import 'package:alcaldias/models/data.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Data> login_service(String email, String passwd) async {
  var client = http.Client();
  try {
    var response = await client.post(Uri.parse(API_URL + "/login"),
        body: {'email': email, 'password': passwd});
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    //bool hasError = decodedResponse['hasError'];
    Data data = Data(
        code: response.statusCode,
        message: decodedResponse["message"] ?? "",
        data: decodedResponse["data"]);
    print(data.toString());
    return data;
  } finally {
    client.close();
  }
}

Future<Data> checkIdentityService(String identidad) async {
  var client = http.Client();
  try {
    var response = await client.post(
      Uri.parse(API_URL + "/check_identity"),
      body: {'identidad': identidad},
    );
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

Future<Data> createUserService(
    String email, String password, String identidad) async {
  var client = http.Client();
  try {
    var response = await client.post(
      Uri.parse(API_URL + "/user"),
      body: {
        'email': email,
        'password': password,
        'identidad': identidad,
      },
    );
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
