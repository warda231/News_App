import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/SearchNewsModel.dart';

import '../Model/NewsModel.dart';
import '../Utils/apikey.dart';

class NewRepository {
  Future<News> fetchNewsApi() async {
    String url =
        'https://api.nytimes.com/svc/topstories/v2/home.json?api-key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return News.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<News> fetch(String category) async {
    String apiCategory = (category == "All") ? "home" : category;
    String encodedCategory = Uri.encodeComponent(apiCategory);
    String url =
        'https://api.nytimes.com/svc/topstories/v2/$encodedCategory.json?api-key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return News.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<SearchNews> fetchNewsCategoryApi(String? searchQuery) async {
    print('Fetching data for query: $searchQuery');

    try {
      String url =
'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=$searchQuery&api-key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return SearchNews.fromJson(body);
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
             throw ApiException('Sorry,No Such news exists.');

      }
    } catch (e) {
      print('Exception: $e');
            throw ApiException('Sorry,No Such news exists.');

    }
  }
}
class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}