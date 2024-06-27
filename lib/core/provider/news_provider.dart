import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:news_app/core/provider/remote_config.dart';
import 'package:news_app/models/news_model.dart';

class NewsProvider with ChangeNotifier {
  NewsResponse? newsResponse;
  bool isLoading = true;
  late RemoteConfigService _remoteConfigService;

  NewsProvider() {
    _fetchCountryCodeAndNews();
  }
  
Future<void> _fetchCountryCodeAndNews() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    _remoteConfigService = RemoteConfigService(remoteConfig);
    await _remoteConfigService.initialize();
 final    countryCode = _remoteConfigService.countryCode;
    if (countryCode.isNotEmpty) {
      await fetchNews(countryCode);
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNews(String countryCode) async {
    isLoading = true;
    notifyListeners();
    final dio = Dio();
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': countryCode,
        'apiKey': '631b54ce2b5748e79aca9c19e8b589e4',
      },
    );

    if (response.statusCode == 200) {
      newsResponse = NewsResponse.fromJson(response.data);
    } else {
      newsResponse = null;
    }

    isLoading = false;
    notifyListeners();
  }
   Future<void> refreshNews(String countryCode) async {
    await fetchNews(countryCode);
  }
}
