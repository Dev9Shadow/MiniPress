import 'package:flutter/material.dart';
import '../models/article_resume.dart';
import '../models/categorie.dart';
import '../services/api_service.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';

class CategorieArticlesScreen extends StatefulWidget {
  final Categorie categorie;
  const CategorieArticlesScreen({super.key, required this.categorie});

  @override
  State<CategorieArticlesScreen> createState() => _CategorieArticlesScreenState();
}

class _CategorieArticlesScreenState extends State<CategorieArticlesScreen> {
  String _sort = 'date-desc';
  late Future<List<ArticleResume>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = ApiService.fetchArticlesByCategorie(widget.categorie.id, sort: _sort);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categorie.libelle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.arrow_downward, size: 16),
                label: const Text('Plus récent'),
                onPressed: () => setState(() { _sort = 'date-desc'; _reload(); }),
              ),
              TextButton.icon(
                icon: const Icon(Icons.arrow_upward, size: 16),
                label: const Text('Plus ancien'),
                onPressed: () => setState(() { _sort = 'date-asc'; _reload(); }),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<ArticleResume>>(
              future: _future,
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
          ),
        ],
      ),
    );
  }
}
