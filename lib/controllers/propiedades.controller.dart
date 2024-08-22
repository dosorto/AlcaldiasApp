import 'package:alcaldias/models/propiedad.model.dart';
import 'package:alcaldias/services/propiedad.service.dart';
import 'package:alcaldias/models/data.model.dart';

class PropiedadController {
  Future<List<Propiedad>> getPropiedades(String token) async {
    Data data = await fetchPropiedades(token);

    if (data.code == 200) {
      // Convertir los datos en una lista de objetos Propiedad
      print(data.data as List<Propiedad>);
      return data.data as List<Propiedad>;
    } else {
      // Manejo de error si el código de respuesta no es 200
      throw Exception('Error al obtener propiedades: ${data.message}');
    }
  }
}
