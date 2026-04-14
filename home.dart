
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = "4dac5a1850084c3b9fdd3e38473a1460";

  List news = [];
  bool loading = false;

  List<String> categories = [
    "india",
    "sports",
    "technology",
    "movies",
    "business"
  ];

  @override
  void initState() {
    super.initState();
    fetchNews("india");
  }

  // 🔥 FETCH NEWS
  Future<void> fetchNews(String query) async {
    setState(() => loading = true);

    final url =
        "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          news = data["articles"];
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => loading = false);
    }
  }

  // 🔥 OPEN NEWS IN BROWSER
  void openNews(String url) async {
    if (url.isEmpty) return;

    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // 🔥 LOGOUT
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TrendSpot 🔥"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),

      body: Column(
        children: [

          // ================= CATEGORIES =================
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      fetchNews(categories[i]);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        categories[i],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ================= NEWS LIST =================
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: news.length,
                    itemBuilder: (context, i) {
                      final item = news[i];

                      String imageUrl = item["urlToImage"] ?? "";

                      if (imageUrl.isEmpty ||
                          !imageUrl.startsWith("http")) {
                        imageUrl =
                            "https://images.unsplash.com/photo-1522202176988-66273c2fd55f";
                      }

                      return GestureDetector(
                        onTap: () {
                          openNews(item["url"] ?? "");
                        },

                        child: Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                      height: 180,
                                      color: Colors.grey,
                                      child: Icon(Icons.image_not_supported),
                                    );
                                  },
                                ),
                              ),

                              // TITLE
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  item["title"] ?? "No Title",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
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