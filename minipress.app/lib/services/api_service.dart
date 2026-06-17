import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../models/article_resume.dart';
import '../models/categorie.dart';
import 'api_exception.dart';

const String _base = 'http://docketu.iutnc.univ-lorraine.fr:57000/api';

class ApiService {
  static Future<T> _get<T>(String url, T Function(dynamic) parse) async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode != 200) {
        throw ApiException(res.statusCode, 'Erreur serveur');
      }
      return parse(jsonDecode(utf8.decode(res.bodyBytes)));
    } on SocketException {
      throw const ApiException(0, 'Pas de connexion réseau');
    }
  }

  static Future<List<Categorie>> fetchCategories() => _get(
      '$_base/categories',
      (j) => (j as List).map((e) => Categorie.fromJson(e)).toList());

  static Future<List<ArticleResume>> fetchArticles({String sort = 'date-desc'}) => _get(
      '$_base/articles?sort=$sort',
      (j) => (j as List).map((e) => ArticleResume.fromJson(e)).toList());

  static Future<Article> fetchArticle(int id) =>
      _get('$_base/articles/$id', (j) => Article.fromJson(j));

  static Future<List<ArticleResume>> fetchArticlesByCategorie(int id,
          {String sort = 'date-desc'}) =>
      _get('$_base/categories/$id/articles?sort=$sort',
          (j) => (j as List).map((e) => ArticleResume.fromJson(e)).toList());

  static Future<List<ArticleResume>> fetchArticlesByAuteur(int id) => _get(
      '$_base/auteurs/$id/articles',
      (j) => (j as List).map((e) => ArticleResume.fromJson(e)).toList());
}
