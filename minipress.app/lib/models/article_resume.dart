import 'auteur.dart';

class ArticleResume {
  final int id;
  final String titre;
  final String? resume;
  final DateTime dateCreation;
  final Auteur auteur;

  const ArticleResume({
    required this.id,
    required this.titre,
    this.resume,
    required this.dateCreation,
    required this.auteur,
  });

  factory ArticleResume.fromJson(Map<String, dynamic> json) => ArticleResume(
        id: json['id'] as int,
        titre: json['titre'] as String,
        resume: json['resume'] as String?,
        dateCreation: DateTime.parse(json['date_creation'] as String),
        auteur: Auteur.fromJson(json['auteur'] as Map<String, dynamic>),
      );
}
