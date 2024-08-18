import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Propiedad(
        nombreContribuyente:
            'Usuario'), // Reemplazar por el id del usuario para obtener el nombre
  ));
}

class Propiedad extends StatelessWidget {
  final String nombreContribuyente;

  Propiedad({required this.nombreContribuyente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        title: Text(
          'Propiedades Registradas',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orangeAccent.shade100,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightBlueAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            // Tarjeta de saludo y nombre del usuario
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getGreeting() + ' ' + nombreContribuyente,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 8.0),
                      _getGreetingIcon(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Tarjeta de propiedades registradas
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Propiedades Registradas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(7, 155, 241, 1),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: 2.0,
                      color: Color(0xFFB3E5FC),
                    ),
                    SizedBox(height: 16.0),
                    Table(
                      columnWidths: {
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                        3: FlexColumnWidth(),
                        4: FixedColumnWidth(
                            80.0), // Ajusta el ancho de la celda de opciones
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          children: [
                            _buildTableCell('Clave Catastral'),
                            _buildTableCell('Tipo de Propiedad'),
                            _buildTableCell('Barrio'),
                            _buildTableCell('Departamento'),
                            _buildTableCell('Opciones')
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableCell(''),
                            _buildTableCell(''),
                            _buildTableCell(''),
                            _buildTableCell(''),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                child: Center(
                                  child: Container(
                                    width: 48, // Ajusta el ancho del contenedor
                                    height:
                                        48, // Ajusta la altura del contenedor
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Acción para el botón
                                        // OJO este botón tiene que llevar a ver el mapa
                                      },
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.orangeAccent.shade100,
                                        padding: EdgeInsets
                                            .zero, // Quita padding extra
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Función para saludo al usuario
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return '¡Buen día!';
    } else if (hour < 18) {
      return '¡Buenas tardes!';
    } else {
      return '¡Buenas noches!';
    }
  }

  Widget _getGreetingIcon() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Icon(
        Icons.wb_sunny,
        color: Color.fromARGB(255, 236, 236, 45),
        size: 24.0,
      );
    } else if (hour < 18) {
      return Icon(
        Icons.wb_sunny,
        color: Color.fromARGB(255, 236, 236, 45),
        size: 24.0,
      );
    } else {
      return Icon(
        Icons.nightlight_round,
        color: Colors.lightBlueAccent,
        size: 24.0,
      );
    }
  }
}
