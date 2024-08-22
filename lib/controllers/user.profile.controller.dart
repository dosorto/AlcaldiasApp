// user_profile_controller.dart
import 'package:alcaldias/models/contribuyente.model.dart';
import 'package:alcaldias/services/contribuyente.service.dart';
import 'package:alcaldias/models/data.model.dart';

class ContribuyenteController {
  // Método para obtener el contribuyente por userId
  Future<Contribuyente> getContribuyente(String token) async {
    Data data = await fetchContribuyente(token);

    if (data.code == 200) {
      // Convertir los datos en un objeto Contribuyente
      Contribuyente contribuyente = Contribuyente.fromJson(data.data);
      return contribuyente;
    } else {
      // Manejo de error si el código de respuesta no es 200
      throw Exception('Error al obtener contribuyente: ${data.message}');
    }
  }
}
