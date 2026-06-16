import 'package:flutter/material.dart';
import '../models/article_resume.dart';
import '../models/categorie.dart';
import '../services/api_service.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ArticleResume>> _articlesFuture;
  late Future<List<Categorie>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiService.fetchArticles();
    _categoriesFuture = ApiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniPress'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Catégories', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const Divider(),
                    ...snap.data!.map((c) => ListTile(
                      title: Text(c.libelle),
                      onTap: () => ScaffoldMessenger.of(ctx)
                          .showSnackBar(SnackBar(content: Text(c.libelle))),
                    )),
                  ],
                );
              },
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: FutureBuilder<List<ArticleResume>>(
              future: _articlesFuture,
              builder: (ctx, snap) {
                if (snap.hasError) return Center(child: Text('Erreur : ${snap.error}'));
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (_, i) => ArticleCard(
                    article: snap.data![i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ArticleScreen(id: snap.data![i].id)),
                    ),
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
