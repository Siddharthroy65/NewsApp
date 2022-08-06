import 'package:NewsApp/circle.dart';
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

  final List topics = [
    'Poilitcs',
    'Sports',
    'Movies',
    'Crime',
    'Tech',
   
  ];
  final Map image_topic_map = {
    'Poilitcs': 'https://png.pngtree.com/png-vector/20190806/ourlarge/pngtree-politics-law-campaign-vote-blue-and-red-download-and-buy-png-image_1652004.jpg',
    'Sports':   'https://arbaminch.gov.et/sites/default/files/images/office/football.jpg',
    'Movies': 'https://t3.ftcdn.net/jpg/04/68/46/32/360_F_468463244_maWHdLG3652zOERm90PJmilPpXZaf7uv.jpg',
    'Crime': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT96ukZOayo6eCJKmCK32_R3LkwXbdAv5KtYQ&usqp=CAU',
    'Tech': 'https://media.istockphoto.com/vectors/case-studies-icon-vector-illustration-on-white-background-vector-id1304219432?k=20&m=1304219432&s=612x612&w=0&h=ifX5GzdkLtmJ16wR0VLDm_l-w2_yNJiJqlmwQ4L23d8=',
   
  };
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
                    elevation: 0,
                    leading: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        )),
                    backgroundColor: Colors.white,
                
                    actions: <Widget>[
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "CNBC",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Hey, Jon!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Discover Latest News",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 45),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
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
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 120,
                              child: ListView.builder(
                                  itemCount: topics.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    return Mycircle(
                                      child: [
                                        topics[index], 
                                        image_topic_map[topics[index]]
                                      ]
                                    );
                                    
                                  })),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Breaking News',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
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
