import 'package:NewsApp/model/article_model.dart';
import 'package:NewsApp/pages/articles_details_page.dart';
import 'package:flutter/material.dart';

Widget customListTile(Article article, BuildContext context) {
  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlePage(
                      article: article,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 1.0,
            //   ),
            // ]
            ),
        child: ListTile(
          leading: SizedBox(
            child: Container(
              height: 300.0,
              child: Image.network(
                article.urlToImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            article.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          subtitle: Text(
            article.source.name,
          ),
        ),
      ));
}
