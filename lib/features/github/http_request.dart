import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'repo.dart';

/// GET /search/repositories API をコールして、
/// [SearchReposResponse] を返す。
Future<SearchReposResponse> searchRepos({
  required String text,
  int perPage = 30,
}) async {
  final uri = Uri.https(
    'api.github.com',
    'search/repositories',
    {
      'q': text,
      'per_page': '$perPage',
    },
  );
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Accept': 'application/vnd.github+json',
      'Authorization':
          'Bearer ${const String.fromEnvironment('GITHUB_ACCESS_TOKEN')}',
    },
  );
  debugPrint(response.body);
  return SearchReposResponse.fromJson(
      (jsonDecode(response.body) as Map<String, dynamic>));
}
