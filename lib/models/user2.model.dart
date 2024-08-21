//probando dejar todo opcional
class User2 {
  final int? id;
  final String? email; // Cambia a tipo opcional
  final String? token; // Cambia a tipo opcional
  final String? nombre; // Cambia a tipo opcional

  User2({
    this.id,
    this.email,
    this.token,
    this.nombre,
  });

  factory User2.fromJson(Map<String, dynamic> json) {
    return User2(
      id: json["id"] as int?,
      email: json["email"] as String?,
      token: json["token"] as String?,
      nombre: json["name"] as String?,
    );
  }
}
