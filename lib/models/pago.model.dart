class Pago {
  final String numRecibo;
  final String fechaPago;
  final String servicio;
  final double total;
  final String estado;

  Pago({
    required this.numRecibo,
    required this.fechaPago,
    required this.servicio,
    required this.total,
    required this.estado,
  });

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      numRecibo: json['num_recibo'] as String,
      fechaPago: json['fecha_pago'] as String,
      servicio: json['servicio'] as String,
      total: json['total'].toDouble(),
      estado: json['estado'] as String,
    );
  }
}
