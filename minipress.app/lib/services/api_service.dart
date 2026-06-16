import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_resume.dart';
import '../models/categorie.dart';

const String _base = 'http://docketu.iutnc.univ-lorraine.fr:57000/api';

class ApiService {
  static Future<List<Categorie>> fetchCategories() async {
    final res = await http.get(Uri.parse('$_base/categories'));
    if (res.statusCode != 200) throw Exception('Erreur HTTP ${res.statusCode}');
    final List json = jsonDecode(res.body);
    return json.map((e) => Categorie.fromJson(e)).toList();
  }

  static Future<List<ArticleResume>> fetchArticles({String sort = 'date-desc'}) async {
    final res = await http.get(Uri.parse('$_base/articles?sort=$sort'));
    if (res.statusCode != 200) throw Exception('Erreur HTTP ${res.statusCode}');
    final List json = jsonDecode(res.body);
    return json.map((e) => ArticleResume.fromJson(e)).toList();
  }
}
