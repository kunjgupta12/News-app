// news_screen.dart
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/core/provider/news_provider.dart';
import 'package:news_app/core/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MyNews',
              style: heading.copyWith(color: Colors.white),
            ),
            Consumer<NewsProvider>(builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());

              } else if (provider.newsResponse != null) {
                    final remoteConfig = FirebaseRemoteConfig.instance;
              final countryCode = remoteConfig.getString('country_code');
          
                return Row(
                  children: [
                    Icon(
                      Icons.navigation,
                      color: Colors.white,
                    ),
                    Text(
                      
                      countryCode.toString().toUpperCase(),
                      style: heading.copyWith(color: Colors.white),
                    )
                  ],
                );
              }
              return CircularProgressIndicator();
            })
          ],
        ),
        backgroundColor: bluedark,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.newsResponse != null) {
             return RefreshIndicator(
            onRefresh: () async {
              final remoteConfig = FirebaseRemoteConfig.instance;
              final countryCode = remoteConfig.getString('country_code');
              await provider.refreshNews(countryCode);
              print(countryCode);
            },child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Top Headlines',
                    style: subheading.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: provider.newsResponse!.articles.length,
                    itemBuilder: (context, index) {
                      final article = provider.newsResponse!.articles[index];
                      final timeAgo = _getTimeAgo(article.publishedAt);

                      return Card(
                        elevation: 2,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.source.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      article.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      article.description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      timeAgo,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              article.urlToImage != null
                                  ?   ClipRRect(
                                       borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        article.urlToImage!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey,
                                      child: Icon(Icons.image,
                                          color: Colors.white),
                                    ),
                              SizedBox(width: 8.0),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              ) );
          } else {
            return Center(child: Text('No news available'));
          }
        },
      ),
    );
  }

  String _getTimeAgo(DateTime? publishedAt) {
    if (publishedAt == null) {
      return 'Unknown time';
    } else {
      return timeago.format(publishedAt);
    }
  }
}
