import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'comment_page.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      _posts = list.map((model) => Post.fromJson(model)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: const _PostsPageContent(),
    );
  }
}

class _PostsPageContent extends StatefulWidget {
  const _PostsPageContent({Key? key});

  @override
  __PostsPageContentState createState() => __PostsPageContentState();
}

class __PostsPageContentState extends State<_PostsPageContent> {
  late Future<void> _fetchPostsFuture;

  @override
  void initState() {
    super.initState();
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    _fetchPostsFuture = postProvider.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _fetchPostsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final postProvider = Provider.of<PostProvider>(context);
            final posts = postProvider.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].title),
                  subtitle: Text(posts[index].body),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentPage(post: posts[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
        required this.id,
        required this.title,
        required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}