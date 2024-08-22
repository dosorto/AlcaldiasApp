import 'package:alcaldias/models/pago.model.dart';
import 'package:alcaldias/models/data.model.dart';
import 'package:alcaldias/services/pago.service.dart';

class PagoController {
  // Método para obtener los pagos pendientes
  Future<List<Pago>> getPagosPendientes(String token) async {
    Data data = await fetchPagosPendientes(token);

    if (data.code == 200) {
      // Convertir los datos en una lista de objetos Pago
      List<Pago> pagos = (data.data as List)
          .map((pagoJson) => Pago.fromJson(pagoJson))
          .toList();
      return pagos;
    } else {
      // Manejo de error si el código de respuesta no es 200
      throw Exception('Error al obtener pagos pendientes: ${data.message}');
    }
  }

  // Método para obtener los pagos pendientes
  Future<List<Pago>> getPagosRealizados(String token) async {
    Data data = await fetchPagosRealizados(token);

    if (data.code == 200) {
      // Convertir los datos en una lista de objetos Pago
      List<Pago> pagos = (data.data as List)
          .map((pagoJson) => Pago.fromJson(pagoJson))
          .toList();
      return pagos;
    } else {
      // Manejo de error si el código de respuesta no es 200
      throw Exception('Error al obtener pagos realizados: ${data.message}');
    }
  }
}
