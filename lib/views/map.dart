import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:alcaldias/controllers/georeferencia.controller.dart';
import 'package:alcaldias/models/georeferencia.model.dart';

class MapaConPoligono extends StatelessWidget {
  final int propiedadId;
  final String token;

  MapaConPoligono({required this.propiedadId, required this.token});

  @override
  Widget build(BuildContext context) {
    print('Propiedad ID: $propiedadId');
    print('Token: $token');
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa con Polígono'),
      ),
      body: FutureBuilder<List<Georeferenciacion>>(
        future: GeoController().getGeoreferenciaciones(propiedadId, token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child:
                    Text('No se encontraron coordenadas para esta propiedad.'));
          } else {
            // Convertimos las georeferenciaciones en una lista de LatLng
            List<LatLng> puntosPoligono = snapshot.data!
                .map((geo) => LatLng(geo.latitud, geo.longitud))
                .toList();

            return FlutterMap(
              options: MapOptions(
                initialCenter: puntosPoligono.isNotEmpty
                    ? puntosPoligono[0]
                    : LatLng(0, 0), // Centra en la primera coordenada
                initialZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: puntosPoligono,
                      color: Colors.blue.withOpacity(0.5),
                      borderStrokeWidth: 3.0,
                      borderColor: Colors.blue,
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
