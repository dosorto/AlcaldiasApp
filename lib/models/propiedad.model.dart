class Propiedad {
  final int id;
  final int claveCatastral;
  final int idContribuyente;
  final String? direccion;
  final int barrioId;
  final String barrio;
  final String aldea;
  final String municipio;
  final String departamento;
  final String pais;
  final int tipoPropiedadId;
  final String tipoPropiedad;

  Propiedad({
    required this.id,
    required this.claveCatastral,
    required this.idContribuyente,
    this.direccion,
    required this.barrioId,
    required this.barrio,
    required this.aldea,
    required this.municipio,
    required this.departamento,
    required this.pais,
    required this.tipoPropiedadId,
    required this.tipoPropiedad,
  });

  factory Propiedad.fromJson(Map<String, dynamic> json) {
    return Propiedad(
      id: json['id'],
      claveCatastral: json['ClaveCatastral'],
      idContribuyente: json['IdContribuyente'],
      direccion: json['Direccion'],
      barrioId: json['barrio_id'],
      barrio: json['barrio'],
      aldea: json['aldea'],
      municipio: json['municipio'],
      departamento: json['departamento'],
      pais: json['pais'],
      tipoPropiedadId: json['tipo_propiedad_id'],
      tipoPropiedad: json['tipo_propiedad'],
    );
  }
}
