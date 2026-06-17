import 'package:flutter/material.dart';
import '../models/article_resume.dart';
import '../services/api_service.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';

class AuteurArticlesScreen extends StatelessWidget {
  final int auteurId;
  final String email;

  const AuteurArticlesScreen({super.key, required this.auteurId, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<ArticleResume>>(
        future: ApiService.fetchArticlesByAuteur(auteurId),
        builder: (ctx, snap) {
          if (snap.hasError) return Center(child: Text('Erreur : ${snap.error}'));
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final articles = snap.data!;
          if (articles.isEmpty) return const Center(child: Text('Aucun article'));
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (_, i) => ArticleCard(
              article: articles[i],
              onTap: () => Navigator.push(ctx, MaterialPageRoute(
                builder: (_) => ArticleScreen(id: articles[i].id),
              )),
            ),
          );
        },
      ),
    );
  }
}
