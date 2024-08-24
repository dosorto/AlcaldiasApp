import 'package:flutter/material.dart';
import 'package:alcaldias/services/password.service.dart';
import 'package:alcaldias/models/data.model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();

  Future<void> forgotPassword() async {
    if (emailController.text.isNotEmpty) {
      Data response = await sendPasswordResetEmail(emailController.text);

      if (response.code == 200) {
        Get.snackbar("Éxito", "Correo de recuperación enviado",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", response.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error", "Por favor ingresa tu correo electrónico",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
