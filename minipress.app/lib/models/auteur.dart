class Auteur {
  final int id;
  final String email;

  const Auteur({required this.id, required this.email});

  factory Auteur.fromJson(Map<String, dynamic> json) =>
      Auteur(id: json['id'] as int, email: json['email'] as String);
}
