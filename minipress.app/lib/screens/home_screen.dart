import 'package:flutter/material.dart';
import '../models/article_resume.dart';
import '../models/categorie.dart';
import '../services/api_service.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';
import 'categorie_articles_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ArticleResume>> _articlesFuture;
  late Future<List<Categorie>> _categoriesFuture;
  String _sort = 'date-desc';
  String _search = '';

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _articlesFuture = ApiService.fetchArticles(sort: _sort);
    _categoriesFuture = ApiService.fetchCategories();
  }

  List<ArticleResume> _filter(List<ArticleResume> articles) {
    if (_search.isEmpty) return articles;
    final kw = _search.toLowerCase();
    return articles
        .where((a) =>
            a.titre.toLowerCase().contains(kw) ||
            (a.resume?.toLowerCase().contains(kw) ?? false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniPress'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un article...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: FutureBuilder<List<Categorie>>(
              future: _categoriesFuture,
              builder: (ctx, snap) {
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                return ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Tous les articles'),
                      onTap: () => setState(() { _sort = 'date-desc'; _reload(); }),
                    ),
                    const Divider(),
                    ...snap.data!.map((c) => ListTile(
                      leading: const Icon(Icons.folder_outlined),
                      title: Text(c.libelle),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CategorieArticlesScreen(categorie: c)),
                      ),
                    )),
                  ],
                );
              },
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      const Text('Trier : ', style: TextStyle(color: Colors.grey)),
                      TextButton.icon(
                        icon: const Icon(Icons.arrow_downward, size: 16),
                        label: const Text('Plus récent'),
                        style: _sort == 'date-desc'
                            ? TextButton.styleFrom(backgroundColor: Colors.indigo.shade50)
                            : null,
                        onPressed: () => setState(() { _sort = 'date-desc'; _reload(); }),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.arrow_upward, size: 16),
                        label: const Text('Plus ancien'),
                        style: _sort == 'date-asc'
                            ? TextButton.styleFrom(backgroundColor: Colors.indigo.shade50)
                            : null,
                        onPressed: () => setState(() { _sort = 'date-asc'; _reload(); }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<ArticleResume>>(
                    future: _articlesFuture,
                    builder: (ctx, snap) {
                      if (snap.hasError) return Center(child: Text('Erreur : ${snap.error}'));
                      if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                      final articles = _filter(snap.data!);
                      if (articles.isEmpty) return const Center(child: Text('Aucun résultat'));
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (_, i) => ArticleCard(
                          article: articles[i],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ArticleScreen(id: articles[i].id)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
