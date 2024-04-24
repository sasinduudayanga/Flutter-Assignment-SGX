import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Albums'),
              Tab(text: 'Posts'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AlbumsPage(),
            PostsPage(),
          ],
        ),
      ),
    );
  }
}

class AlbumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Albums Page'),
    );
  }
}

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                builder: (context) => CommentPage(postId: posts[index].id),
              ),
            );
          },
        );
      },
    );
  }
}

class CommentPage extends StatelessWidget {
  final int postId;

  CommentPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].body),
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
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});
}

class Comment {
  final int postId;
  final int id;
  final String name;
  final String body;

  Comment({required this.postId, required this.id, required this.name, required this.body});
}

List<Post> posts = [
  Post(id: 1, title: 'Post 1', body: 'Body of Post 1'),
  Post(id: 2, title: 'Post 2', body: 'Body of Post 2'),
];

Future<List<Comment>> fetchComments(int postId) async {
  // Simulating fetching comments from an API
  await Future.delayed(Duration(seconds: 1));

  // Returning dummy comments for demonstration
  return List.generate(
    5,
    (index) => Comment(
      postId: postId,
      id: index + 1,
      name: 'Comment ${index + 1}',
      body: 'Body of Comment ${index + 1}',
    ),
  );
}
