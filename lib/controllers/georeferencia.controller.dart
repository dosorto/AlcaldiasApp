import 'package:alcaldias/services/georeferencia.service.dart';
import 'package:alcaldias/models/georeferencia.model.dart';

class GeoController {
  final GeoreferenciacionService _georeferenciacionService =
      GeoreferenciacionService();

  Future<List<Georeferenciacion>> getGeoreferenciaciones(
      int propiedadId, String token) async {
    try {
      return await _georeferenciacionService.fetchGeoreferenciaciones(
          propiedadId, token);
    } catch (e) {
      throw Exception('Error al obtener las georeferenciaciones: $e');
    }
  }
}
