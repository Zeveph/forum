class User {
  final int id;
  //final DateTime dateInscription;
  final List<String> roles; // roles étant une liste
  final String email;
  final String userLastName; //Pas pris car données personnelles
  final String userFirstName; //Pas pris car données personnelles
  User({
    required this.id,
    //required this.dateInscription,
    required this.userLastName, //Pas pris car données personnelles
    required this.userFirstName, //Pas pris car données personnelles
    required this.roles,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      userFirstName: json['prenom'] ?? '',
      userLastName: json["nom"] ?? '',
      //dateInscription: DateTime.parse(json['dateInscription']),
      //roles: json['roles'] ?? [],
      roles: (json['roles'] as List<dynamic>? ?? []).cast<String>(),
      // On récupère rôles, on lui dit que c'est une liste qui peut-être nul.
      email: json['email'] ?? '',
    );
  }
}
