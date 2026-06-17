import 'package:flutter/material.dart';
import '../models/article_resume.dart';

class ArticleCard extends StatelessWidget {
  final ArticleResume article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, "0")}/${d.month.toString().padLeft(2, "0")}/${d.year}';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(article.titre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${_fmt(article.dateCreation)} • ${article.auteur.email}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
