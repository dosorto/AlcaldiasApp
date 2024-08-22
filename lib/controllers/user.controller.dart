import 'dart:convert';
import 'package:alcaldias/models/data.model.dart';
import 'package:alcaldias/models/user.model.dart';
import 'package:alcaldias/models/user2.model.dart';
import 'package:alcaldias/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late TextEditingController username;
  late TextEditingController name;
  late TextEditingController password;
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

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
    isLoading.value = true; // Iniciar el indicador de carga
    Data data = (await login_service(username.text, password.text));
    switch (data.code) {
      case 200:
        {
          User user = User.fromJson(data.data);
          print(user.nombre);
          await _saveToken(user.token);
          await _saveNombre(user.nombre);
          isLoading.value = false;
          return true;
        }
      case 403:
        {
          print(data.message);
          isLoading.value = false;
          return false;
        }
      case 203:
        {
          print("sin Acceso: token sin acceso");
          isLoading.value = false;
          return false;
        }
      default:
        {
          print("algo salio mal");
          isLoading.value = false;
          return false;
        }
    }
  }

  // Método para registrar usuario
  Future<String> registerUser(
      String email, String password, String identidad) async {
    try {
      Data identityCheck = await checkIdentityService(identidad);
      if (identityCheck.code == 200) {
        Data registerResponse =
            await createUserService(email, password, identidad);
        if (registerResponse.code == 200) {
          User2 user = User2.fromJson(registerResponse.data);
          print('Usuario registrado exitosamente: ${user.nombre}');
          String existingEmail = identityCheck.data['contribuyente']['email'];
          print('Usuario ya registrado con correo: $existingEmail');
          return existingEmail; // Devuelve el correo existente
        } else if (registerResponse.code == 409) {
          // Manejar el caso donde el usuario ya está registrado
          String existingEmail = identityCheck.data['contribuyente']['email'];
          print('Usuario ya registrado con correo: $existingEmail');
          return existingEmail; // Devuelve el correo existente
        } else {
          // Manejar otros errores en la respuesta de la API
          print('Error al registrar: ${registerResponse.message}');
          return registerResponse.message ?? 'Error al registrar usuario.';
        }
      } else {
        // Manejar errores en la verificación de identidad
        print(
            'Error en la verificación de identidad: ${identityCheck.message}');
        return identityCheck.message ?? 'Error al verificar identidad.';
      }
    } catch (e) {
      // Capturar y manejar cualquier excepción que ocurra durante la solicitud
      print('Excepción durante el registro: $e');
      return 'Error inesperado durante el registro. Por favor, inténtelo de nuevo.';
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Método para obtener el token almacenado
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _saveNombre(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre_usuario', nombre);
  }

  // Método para obtener el token almacenado
  Future<String?> getNombre() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre_usuario');
  }
}
