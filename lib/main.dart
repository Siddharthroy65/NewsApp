import 'package:NewsApp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'components/customListTile.dart';
import 'model/article_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

var dbDeleted = 0;

Future<void> deleteDBOnStart() async {
  String path = join(await getDatabasesPath(), "news.db");
  deleteDatabase(path);
}

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(leading: IconButton(onPressed: () {
     
   }, icon: Icon(Icons.menu,color: Colors.black,)),
   backgroundColor: Color(0xFFFAFAFA),
   centerTitle: true,
   title: Text("News Headline",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
    actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications,color: Colors.red,),
            
          ), //IconButton
        
        ],
   ),
    
      body:Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Text('Trending Topics',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,),),
                 ),
                  FutureBuilder(
                    
                    future: client.getArticle(),
                    builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
                      if (dbDeleted == 0){
                        deleteDBOnStart().then((value) => value);
                        dbDeleted=1;
                      }
                      if (snapshot.hasData) {
                      
                        List<Article> articles = snapshot.data;
                        return ListView.builder(
                    shrinkWrap: true,
                          itemCount: articles.length,
                          itemBuilder: (context, index) =>
                              customListTile(articles[index], context),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
   
      
    );
  }
}
