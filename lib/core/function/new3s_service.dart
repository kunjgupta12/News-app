// news_service.dart
import 'package:dio/dio.dart';
import 'package:news_app/models/news_model.dart';

class NewsService {
  final Dio _dio = Dio();
  final String _apiKey = '631b54ce2b5748e79aca9c19e8b589e4';
  final String _url = 'https://newsapi.org/v2/top-headlines';

  Future<NewsResponse> fetchNews() async {
    final response = await _dio.get(_url, queryParameters: {
      'country': 'in',
      'apiKey': _apiKey,
    });

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
