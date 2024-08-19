import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaConPoligono extends StatelessWidget {
  // Definir las coordenadas del polígono
  final List<LatLng> puntosPoligono = [
    LatLng(14.0723, -87.1921),
    LatLng(14.0733, -87.1922),
    LatLng(14.0734, -87.1931),
    LatLng(14.0724, -87.1930),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa con Polígono'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(14.0723, -87.1921),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
      ),
    );
  }
}
