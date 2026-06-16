class Categorie {
  final int id;
  final String libelle;

  const Categorie({required this.id, required this.libelle});

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      Categorie(id: json['id'] as int, libelle: json['libelle'] as String);
}
