import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'post_page.dart';

class CommentProvider extends ChangeNotifier {
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchComments(int postId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId/comments'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      _comments = list.map((model) => Comment.fromJson(model)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}

class CommentPage extends StatelessWidget {
  final Post post;

  CommentPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommentProvider(),
      child: _CommentPageContent(post: post),
    );
  }
}

class _CommentPageContent extends StatefulWidget {
  final Post post;

  const _CommentPageContent({Key? key, required this.post}) : super(key: key);

  @override
  __CommentPageContentState createState() => __CommentPageContentState();
}

class __CommentPageContentState extends State<_CommentPageContent> {
  late Future<void> _fetchCommentsFuture;

  @override
  void initState() {
    super.initState();
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);
    _fetchCommentsFuture = commentProvider.fetchComments(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for ${widget.post.title}'),
      ),
      body: FutureBuilder<void>(
        future: _fetchCommentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final commentProvider = Provider.of<CommentProvider>(context);
            final comments = commentProvider.comments;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].name),
                  subtitle: Text(comments[index].body),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Comment {
  final int postId;
  final int id;
  final String name;
  final String body;

  Comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      body: json['body'],
    );
  }
}