class Contribuyente {
  final String identidad;
  final String? primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;
  final int? sexo;
  final double? impuestoPersonal;
  final String? direccion;
  final String? apartadoPostal;
  final String? telefono;
  final String? email;
  final String? fechaNacimiento;
  final int? tipoDocumentoId;
  final int? barrioId;
  final int? profesionId;

  Contribuyente({
    required this.identidad,
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.sexo,
    this.impuestoPersonal,
    this.direccion,
    this.apartadoPostal,
    this.telefono,
    this.email,
    this.fechaNacimiento,
    this.tipoDocumentoId,
    this.barrioId,
    this.profesionId,
  });

  Contribuyente.fromJson(Map<String, dynamic> json)
      : identidad = json['identidad'],
        primerNombre = json['primer_nombre'],
        segundoNombre = json['segundo_nombre'],
        primerApellido = json['primer_apellido'],
        segundoApellido = json['segundo_apellido'],
        sexo = json['sexo'],
        impuestoPersonal = json['impuesto_personal'],
        direccion = json['direccion'],
        apartadoPostal = json['apartado_postal'],
        telefono = json['telefono'],
        email = json['email'],
        fechaNacimiento = json['fecha_nacimiento'],
        tipoDocumentoId = json['tipo_documento_id'],
        barrioId = json['barrio_id'],
        profesionId = json['profesion_id'];
}
