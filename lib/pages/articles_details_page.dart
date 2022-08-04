//Now let's create the article details page

import 'package:NewsApp/main.dart';
import 'package:NewsApp/model/article_model.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyApp(),),);
          },
        ),
           backgroundColor: Color(0xFFFAFAFA),
           actions: [
             Padding(
               padding: const EdgeInsets.only(right:5.0),
               child: Container(
           height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'))),
                    ),
             ),
           ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6blHRVxFa_mmHF_sX8tU80rswLwy7sU3SMw&usqp=CAU'))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: VerticalDivider(
                      color: Colors.black,
                      thickness: 4,
                    ),
                  ),
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          Text(
            article.source.name,
          ),
                      Text(
                        'CNBC Media Channel',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                     
                    ],
                  ),
               
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(6.0),
              child: Text(
                article.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 35),
              ),
            ),
            Text(
              article.description,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.black54),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 270.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
