/// Search repositories API のレスポンスボディ。
class SearchReposResponse {
  SearchReposResponse({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<Repo> items;

  factory SearchReposResponse.fromJson(Map<String, dynamic> json) =>
      SearchReposResponse(
        totalCount: json['total_count'] as int,
        items: [
          for (final json in json['items'] as List) Repo.fromJson(json),
        ],
      );
}

/// GitHub リポジトリ。
class Repo {
  Repo({
    required this.id,
    required this.name,
    required this.description,
    required this.language,
    required this.stargazersCount,
  });

  final int id;
  final String name;
  final String description;
  final String language;
  final int stargazersCount;

  factory Repo.fromJson(Map<String, dynamic> json) => Repo(
        id: json['id'] as int,
        name: json['name'] as String,
        description: (json['description'] ?? '') as String,
        language: (json['language'] ?? '') as String,
        stargazersCount: json['stargazers_count'] as int,
      );
}
