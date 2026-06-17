import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/article.dart';
import '../services/api_service.dart';
import 'auteur_articles_screen.dart';
import 'categorie_articles_screen.dart';

class ArticleScreen extends StatelessWidget {
  final int id;

  const ArticleScreen({super.key, required this.id});

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, "0")}/${d.month.toString().padLeft(2, "0")}/${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Article>(
        future: ApiService.fetchArticle(id),
        builder: (ctx, snap) {
          if (snap.hasError) return Center(child: Text('Erreur : ${snap.error}'));
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final a = snap.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.titre,
                    style: Theme.of(ctx)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(_fmt(a.dateCreation),
                        style: const TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(width: 12),
                    const Icon(Icons.person, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (_) => AuteurArticlesScreen(
                              auteurId: a.auteur.id, email: a.auteur.email),
                        ),
                      ),
                      child: Text(a.auteur.email,
                          style: const TextStyle(
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                              fontSize: 13)),
                    ),
                  ],
                ),
                if (a.categorie != null) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      ctx,
                      MaterialPageRoute(
                          builder: (_) => CategorieArticlesScreen(categorie: a.categorie!)),
                    ),
                    child: Chip(label: Text(a.categorie!.libelle)),
                  ),
                ],
                const Divider(height: 24),
                MarkdownBody(data: a.contenu),
              ],
            ),
          );
        },
      ),
    );
  }
}
