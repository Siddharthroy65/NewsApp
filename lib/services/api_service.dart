import 'dart:async';
import 'dart:convert';
import 'package:NewsApp/model/article_model.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class ApiService {
  
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5c597f3766bb42dd95108bb4db529e90";
  
  Future<Database> getDb() async {
    String path = join(await getDatabasesPath(), "news.db");
    Database db;
    try {
      db = await openDatabase(path);
      await db.execute(
      'CREATE TABLE IF NOT EXISTS articles(id INTEGER AUTO_INCREMENT PRIMARY KEY, status VARCHAR, total_results INTEGER, articles JSON);');
    } catch (e) {
      print("Error $e");
    }
    return db;
  }

  Future<List<dynamic>> getData() async {
    Database db = await getDb();
    List<dynamic> articlesData = await db.rawQuery("select * from articles");
    List<dynamic> articles=[];
    if (articlesData.length >0) {
      articles = jsonDecode(articlesData[0]['articles']);
    }
    if (articles.length>0) {
      print('Data returned from DB');
    }
    else{
      Response res = await get(endPointUrl);
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        var status = json['status'];
        var totalResults = json['totalResults'];
        articles = json['articles'];
        await db.rawInsert('INSERT INTO articles(status, total_results, articles) values(?, ?, ?)', 
        [status, totalResults, jsonEncode(articles)]);
        print('Data returned from News API');
      }
    }
    db.close();
    return articles;
  }

  Future<List<Article>> getArticle() async {
    List<dynamic> data = await getData();
    if (data.length >0) {
      List<Article> articles =
          data.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
