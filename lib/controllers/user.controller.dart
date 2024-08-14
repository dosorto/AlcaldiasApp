import 'dart:convert';
import 'package:alcaldias/models/data.model.dart';
import 'package:alcaldias/models/user.model.dart';
import 'package:alcaldias/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late TextEditingController username;
  late TextEditingController name;
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
    Data data = (await login_service(username.text, password.text));
    switch (data.code) {
      case 200:
        {
          User user = User.fromJson(data.data);
          print(user.nombre);
          return true;
        }
      case 403:
        {
          print(data.message);
          return false;
        }
      case 203:
        {
          print("sin Acceso: token sin acceso");
          return false;
        }
      default:
        {
          print("algo salio mal");
          return false;
        }
    }
  }

  Future<bool> create_user_controller() async {
    Data data =
        (await create_user_service(name.text, username.text, password.text));
    switch (data.code) {
      case 200:
        {
          //User user = User.fromJson(data.data);
          // print(user.nombre);
          return true;
        }
      case 403:
        {
          print(data.message);
          return false;
        }
      case 203:
        {
          print("sin Acceso: token sin acceso");
          return false;
        }
      default:
        {
          print("algo salio mal");
          return false;
        }
    }
  }
}
