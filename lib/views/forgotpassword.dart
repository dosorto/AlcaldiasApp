// forgot_password.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alcaldias/controllers/loginController.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
        backgroundColor: Colors.blue[900],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // Reemplazar con la ruta de tu logo
                      height: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'GLP',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    InputBox(
                      isSecured: false,
                      hint: 'Email',
                      txtController: controller.username,
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: Get.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue[900],
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          // TODO: Implement forgot password functionality
                        },
                        child: const Text('Enviar correo de confirmación'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget InputBox({
  required String hint,
  required TextEditingController txtController,
  required bool isSecured,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      obscureText: isSecured,
      controller: txtController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue[900]),
      ),
    ),
  );
}
