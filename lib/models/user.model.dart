class User {
  int id;
  String email;
  String token;
  String nombre;

  User({
    required this.id,
    required this.email,
    required this.token,
    required this.nombre,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        email = json["email"],
        nombre = json["name"],
        token = json["token"];
}
