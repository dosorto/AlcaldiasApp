import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alcaldias/controllers/user.controller.dart';
import 'package:alcaldias/views/forgotpassword.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alcaldias/views/user.register.dart';

class Login extends StatelessWidget {
  const Login();

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5DC),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150.h, // Tamaño aumentado
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'GLP', // Texto cambiado
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    InputBox(
                      isSecured: false,
                      hint: 'Usuario',
                      txtController: controller.username,
                      icon: Icons.person,
                    ),
                    SizedBox(height: 20.h),
                    Obx(() => InputBox(
                          isSecured: controller.isPasswordHidden.value,
                          hint: 'Contraseña',
                          txtController: controller.password,
                          icon: Icons.lock,
                          toggleVisibility: controller.togglePasswordVisibility,
                          isPasswordField: true,
                          isPasswordHidden: controller.isPasswordHidden.value,
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.to(const ForgotPassword());
                        },
                        child: const Text(
                          '¿Olvidaste la contraseña?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: Get.width,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue[900],
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        onPressed: () async {
                          bool success = await controller.submit();
                          if (!success) {
                            Get.snackbar(
                              'Error',
                              'Usuario o contraseña incorrectos',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: const Text('Ingresar'),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const RegisterScreen());
                      },
                      child: const Text(
                        'Registrarte',
                        style: TextStyle(color: Colors.white),
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
  Function()? toggleVisibility,
  bool isPasswordField = false,
  bool isPasswordHidden = true,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: TextField(
      obscureText: isSecured,
      controller: txtController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue[900]),
        suffixIcon: isPasswordField
            ? IconButton(
                icon: Icon(
                  isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue[900],
                ),
                onPressed: toggleVisibility,
              )
            : null,
      ),
    ),
  );
}
