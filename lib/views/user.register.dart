import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alcaldias/controllers/user.controller.dart'; // Asegúrate de que el controlador esté en la ruta correcta
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final LoginController _loginController =
      Get.put(LoginController()); // Instancia el controlador

  String _message = '';
  bool _isLoading = false;

  // Controla la visibilidad de la contraseña
  var _isPasswordHidden = true.obs;
  var _isConfirmPasswordHidden = true.obs;

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isLoading = false;
        _message = 'Las contraseñas no coinciden.';
      });
      return;
    }

    String responseMessage = await _loginController.registerUser(
      _emailController.text,
      _passwordController.text,
      _identityController.text,
    );

    setState(() {
      _isLoading = false;

      // Verifica si la respuesta contiene un correo electrónico
      if (responseMessage.contains('@')) {
        _emailController.text = responseMessage;
        _message = 'Usuario ya registrado con el correo: $responseMessage';
      } else if (responseMessage.isEmpty) {
        _message = 'Usuario registrado exitosamente.';
      } else {
        _message = responseMessage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 132, 224),
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        backgroundColor: Colors.orange.shade100,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _identityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Número de Identidad',
                  prefixIcon: Icon(Icons.badge),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                readOnly: true, // Hace que el TextField sea de solo lectura
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: _emailController.text));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Correo copiado al portapapeles')));
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Obx(() => TextField(
                    controller: _passwordController,
                    obscureText: _isPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          _isPasswordHidden.value = !_isPasswordHidden.value;
                        },
                      ),
                    ),
                  )),
              const SizedBox(height: 16.0),
              Obx(() => TextField(
                    controller: _confirmPasswordController,
                    obscureText: _isConfirmPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isConfirmPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          _isConfirmPasswordHidden.value =
                              !_isConfirmPasswordHidden.value;
                        },
                      ),
                    ),
                  )),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Registrar Usuario'),
              ),
              const SizedBox(height: 16.0),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: _message.contains('Error') ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
