class User {
  int id;
  String email;
  String token;
  String nombre;
  String apellido;

  User({
    required this.id,
    required this.email,
    required this.token,
    required this.nombre,
    required this.apellido,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json["user"]["id"],
        email = json["user"]["email"],
        nombre = json["user"]["nombres"],
        apellido = json["user"]["apellidos"],
        token = json["token"];
}
