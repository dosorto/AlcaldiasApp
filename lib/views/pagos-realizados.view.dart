import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alcaldias/controllers/pago.controller.dart';
import 'package:alcaldias/models/pago.model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PagosRealizados(
        nombreContribuyente: 'Usuario',
        token: 'tu_token_aqui'), // Tiene que llevar el nombre del usuario
  ));
}

class PagosRealizados extends StatelessWidget {
  final String nombreContribuyente;
  final String token;

  PagosRealizados({required this.nombreContribuyente, required this.token});

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
        title: Text('Pagos Realizados'),
        backgroundColor: Colors.orangeAccent.shade100,
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
        child: FutureBuilder<List<Pago>>(
          future: PagoController().getPagosRealizados(token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay pagos realizados.'));
            } else {
              List<Pago> pagos = snapshot.data!;
              return ListView(
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
                  // Tarjeta de Historial de Pagos Realizados
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Pagos Realizados',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFC156),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            height: 2.0,
                            color: Color.fromRGBO(224, 26, 46, 1),
                          ),
                          SizedBox(height: 16.0),
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                              3: FlexColumnWidth(),
                              4: FlexColumnWidth(),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                children: [
                                  _buildTableCell('No. Recibo'),
                                  _buildTableCell('Fecha'),
                                  _buildTableCell('Servicio'),
                                  _buildTableCell('Monto'),
                                  _buildTableCell('Estado'),
                                ],
                              ),
                              ...pagos.map((pago) => TableRow(
                                    children: [
                                      _buildTableCell(pago.numRecibo),
                                      _buildTableCell(pago.fechaPago),
                                      _buildTableCell(pago.servicio),
                                      _buildTableCell(pago.total.toString()),
                                      _buildTableCell(pago.estado),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
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
