import 'auteur.dart';
import 'categorie.dart';

class Article {
  final int id;
  final String titre;
  final String? resume;
  final String contenu;
  final DateTime dateCreation;
  final Auteur auteur;
  final Categorie? categorie;
  final String? image;

  const Article({
    required this.id,
    required this.titre,
    this.resume,
    required this.contenu,
    required this.dateCreation,
    required this.auteur,
    this.categorie,
    this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'] as int,
        titre: json['titre'] as String,
        resume: json['resume'] as String?,
        contenu: json['contenu'] as String,
        dateCreation: DateTime.parse(json['date_creation'] as String),
        auteur: Auteur.fromJson(json['auteur'] as Map<String, dynamic>),
        categorie: json['categorie'] != null
            ? Categorie.fromJson(json['categorie'] as Map<String, dynamic>)
            : null,
        image: json['image'] as String?,
      );
}
