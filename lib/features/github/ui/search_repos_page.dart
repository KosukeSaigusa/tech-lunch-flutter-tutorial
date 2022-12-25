import 'package:flutter/material.dart';

import '../http_request.dart';
import '../repo.dart';

/// GitHub の Search repositories API を使用して、
/// GitHub のリポジトリ検索を行うページ。
class SearchReposPage extends StatefulWidget {
  const SearchReposPage({super.key});

  @override
  SearchReposPageState createState() => SearchReposPageState();
}

class SearchReposPageState extends State<SearchReposPage> {
  late Future<SearchReposResponse> _repos;
  late final TextEditingController _searchWordController;

  @override
  void initState() {
    _searchWordController = TextEditingController()..text = 'flutter';
    _repos = searchRepos(text: _searchWordController.value.text);
    super.initState();
  }

  @override
  void dispose() {
    _searchWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Repos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchWordController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () async {
                    final text = _searchWordController.value.text;
                    if (text.isEmpty) {
                      return;
                    }
                    _repos = searchRepos(text: text);
                    setState(() {});
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<SearchReposResponse>(
                future: _repos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final response = snapshot.data;
                  final repos = response?.items ?? [];
                  if (repos.isEmpty) {
                    return const Center(child: Text('結果が見つかりませんでした。'));
                  }
                  return ListView.builder(
                    itemCount: repos.length,
                    itemBuilder: (context, index) => _RepoItem(repos[index]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

/// 検索結果の GitHub のリポジトリのひとつひとつのウィジェット。
class _RepoItem extends StatelessWidget {
  const _RepoItem(this.repo);

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        repo.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: repo.description.isNotEmpty ? Text(repo.description) : null,
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 2),
            child: Icon(Icons.star, size: 14),
          ),
          Text(repo.stargazersCount.toString()),
        ],
      ),
    );
  }
}
