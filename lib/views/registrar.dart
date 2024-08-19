import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';
  bool _isLoading = false;
  bool _isIdentityVerified = false;

  Future<void> _verifyIdentity() async {
    final String numeroidentidad = _idController.text;

    if (numeroidentidad.isEmpty) {
      setState(() {
        _message = 'Por favor ingrese su número de identidad';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final response = await http.get(
        Uri.parse('https://api-verificar-identidad/$numeroidentidad'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == 'found_person') {
          // Persona encontrada, permitir ingresar contraseña y registrar usuario
          setState(() {
            _isIdentityVerified = true;
            _message = '';
          });
        } else if (responseData['status'] == 'found_user') {
          // Usuario ya existe
          setState(() {
            _message = 'Usuario ya creado';
          });
        } else {
          // No se encontró ni como persona ni como usuario
          setState(() {
            _message = 'Identidad no encontrada en el sistema';
          });
        }
      } else {
        setState(() {
          _message = 'Error al conectar con el servidor';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _registerUser() async {
    final String identityNumber = _idController.text;
    final String password = _passwordController.text;

    if (password.isEmpty) {
      setState(() {
        _message = 'Por favor ingrese una contraseña';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://api-crear-usuario'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'identity_number': identityNumber,
          'password': password, // La contraseña proporcionada por el usuario
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _message = 'Usuario creado exitosamente';
          _isIdentityVerified = false; // Restablecer el estado
        });
        _idController.clear();
        _passwordController.clear();
      } else {
        setState(() {
          _message = 'Error al crear el usuario';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        backgroundColor: Colors.orange.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de Identidad',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_isIdentityVerified) ...[
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Registrar Usuario'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyIdentity,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Verificar Identidad'),
              ),
            ],
            const SizedBox(height: 16.0),
            Text(
              _message,
              style: TextStyle(
                fontSize: 16.0,
                color: _message.contains('error') ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
