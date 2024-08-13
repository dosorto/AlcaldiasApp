import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late TextEditingController username;
  late TextEditingController password;
  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<bool> submit() async {
    final url = Uri.parse('http://localhost:3000/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
        'password': password.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success']) {
        final token = responseData['token'];
        // Store the token securely and proceed to the next screen
        print('Login successful, token: $token');
        return true;
      } else {
        print('Login failed, message: ${responseData['message']}');
        return false;
      }
    } else {
      print('Server error, status code: ${response.statusCode}');
      return false;
    }
  }
}
