import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _firstSurnameController = TextEditingController();
  final TextEditingController _secondSurnameController =
      TextEditingController();
  final TextEditingController _personalTaxController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedGender;
  DateTime? _selectedDate;
  String _message = '';
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
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
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'Primer Nombre',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _secondNameController,
                decoration: InputDecoration(
                  labelText: 'Segundo Nombre',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _firstSurnameController,
                decoration: InputDecoration(
                  labelText: 'Primer Apellido',
                  prefixIcon: Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _secondSurnameController,
                decoration: InputDecoration(
                  labelText: 'Segundo Apellido',
                  prefixIcon: Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'M',
                    child: Text('Masculino'),
                  ),
                  DropdownMenuItem(
                    value: 'F',
                    child: Text('Femenino'),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'Sexo',
                  prefixIcon: Icon(Icons.transgender),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _personalTaxController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Impuesto Personal',
                  prefixIcon: Icon(Icons.attach_money),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  prefixIcon: Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Apartado Postal',
                  prefixIcon: Icon(Icons.mail_outline),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      hint: Text('Código'),
                      items: [
                        DropdownMenuItem(
                          value: '+1',
                          child: Text('+1'),
                        ),
                        DropdownMenuItem(
                          value: '+504',
                          child: Text('+504'),
                        ),
                      ],
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.flag),
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    flex: 3,
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        prefixIcon: Icon(Icons.phone),
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Fecha de Nacimiento',
                    prefixIcon: Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: Text(
                    _selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                        : 'Seleccione una fecha',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _isLoading ? null : () {},
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
                  color: _message.contains('error') ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
