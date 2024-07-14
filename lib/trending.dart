import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/httpRequest.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

// void trending() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp();
//
//   runApp(ChangeNotifierProvider(
//     create: (context) => ApplicationState(),
//     builder: ((context, child) => const MyApp()),
//   ));
// }


class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage>{

  String trendingPageTitle = "";
  String trendingPageDescription = "";
  String trendingPageImageUrl = "";

  List<Post> posts = [];

  bool _assetsLoaded = false;

  //Function for fetching data from our api
  void fetchData() async {
    //declare url
    var trending_items_url = Uri.parse(APIurl + '/get_trending_header_items');
    var posts_items_url = Uri.parse(APIurl + '/get_posts');

    try {
      // http GET request
      var trending_items_response = await http.get(trending_items_url);
      var posts_items_response = await http.get(posts_items_url);

      //check if response was successful
      if (trending_items_response.statusCode == 200 && posts_items_response.statusCode == 200) {

        var trendingItems = jsonDecode(trending_items_response.body);
        List<dynamic> postItems = jsonDecode(posts_items_response.body);

        setState(() {
          trendingPageTitle = trendingItems["title"];
          trendingPageDescription = trendingItems["description"];
          trendingPageImageUrl = trendingItems["image_url"];

          posts = postItems.map((postJson) => Post.fromJson(postJson)).toList();

          _assetsLoaded = true;
        });
      } else  {
        print("Request failed");
      }
    } catch (e) {
      print("error: $e");
    }
  }


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void redirectToHttpPage(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HttpPage()));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      if(!_assetsLoaded){
        return Center(
          child:CircularProgressIndicator()
        );
      }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: beigeColor,
          toolbarHeight: 100,
          title: Column(
            children: [
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Image.asset(
                  'assets/chessproject.jpeg',
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
            actions: [
              IconButton(
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HttpPage()));
             },
            icon: Icon(Icons.chat))
          ],
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // build the Trending Page header
            _buildTrendingHeader(),
            SizedBox(height: 20),
            _buildPostSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingHeader(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(trendingPageTitle, style: TextStyle(fontSize: 19)),
        SizedBox(height: 20),
        Image.network(trendingPageImageUrl),
        SizedBox(height: 30),
        Text(trendingPageDescription, style: TextStyle(fontSize: 15)),
        SizedBox(height: 40),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _buildPostSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20, width: 30),
        Column(
          children: posts.map((post) {
            return Column(
              children: [
                Center(
                  child: _buildPostItem(post.imageUrl, post.title, post.description, post.articleUrl),
                ),
                Center(
                  child: SizedBox(height: 30),
                )
              ]);
          }).toList()
        )
      ],
    );
  }

  Widget _buildPostItem(String image_url, String title, String description, String article_url){
    return GestureDetector(
        onTap: () {
          // make the user be redirected to the article_url
        },
        child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(image_url, height: 200),
                SizedBox(height: 10),
                Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(description, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal))
              ],
            )
        )
    );
  }
}


class Post {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;

  Post({required this.title, required this.description, required this.imageUrl, required this.articleUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      articleUrl: json['article_url'],
    );
  }
}
