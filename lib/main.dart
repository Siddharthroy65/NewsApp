import 'package:NewsApp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'components/customListTile.dart';
import 'model/article_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:NewsApp/prefs/style.dart' as Style;
import 'package:NewsApp/prefs/theme_provider.dart';
import 'package:provider/provider.dart';

var dbDeleted = 0;

Future<void> deleteDBOnStart() async {
  String path = join(await getDatabasesPath(), "news.db");
  deleteDatabase(path);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool switchValue = false;
  ThemeProvider themeProvider = ThemeProvider();
  ApiService client = ApiService();

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Style.Style.themeData(themeProvider.darkTheme),
              home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        )),
                    backgroundColor: Color(0xFFFAFAFA),
                    centerTitle: true,
                    title: Text(
                      "News Headline",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      Switch(
                          value: switchValue,
                          onChanged: (val) {
                            themeProvider.darkTheme = !themeProvider.darkTheme;
                            setState(() {
                              switchValue = val;
                            });
                          })
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("CNBC",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("HEY, Jon",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("Discover Latest News",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 45),),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Search for news',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                suffixIcon: Container(
                                  color: Colors.red,
                                  child:
                                      Icon(Icons.search, color: Colors.white),
                                )),
                          ),
                        ),
                        SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Breaking News',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
             ),
                        FutureBuilder(
                          future: client.getArticle(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Article>> snapshot) {
                            if (dbDeleted == 0) {
                              deleteDBOnStart().then((value) => value);
                              dbDeleted = 1;
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
                  )));
        },
      ),
    );
  }
}
