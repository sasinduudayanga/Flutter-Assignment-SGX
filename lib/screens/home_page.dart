import 'package:flutter/material.dart';
import 'album_page.dart';
import 'post_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Albums'),
              Tab(text: 'Posts'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AlbumsPage(),
            PostsPage(),
          ],
        ),
      ),
    );
  }
}

// class AlbumsPage extends StatefulWidget {
//   const AlbumsPage({super.key});
//
//   @override
//   _AlbumsPageState createState() => _AlbumsPageState();
// }
//
// class _AlbumsPageState extends State<AlbumsPage> {
//   late Future<List<Album>> _albums;
//
//   @override
//   void initState() {
//     super.initState();
//     _albums = fetchAlbums();
//   }
//
//   Future<List<Album>> fetchAlbums() async {
//     final response = await http
//         .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
//     if (response.statusCode == 200) {
//       Iterable list = json.decode(response.body);
//       return list.map((model) => Album.fromJson(model)).toList();
//     } else {
//       throw Exception('Failed to load albums');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Album>>(
//       future: _albums,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           return ListView.builder(
//             padding: const EdgeInsets.all(8),
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(snapshot.data![index].title),
//               );
//
//             },
//           );
//         }
//       },
//     );
//   }
// }

// class PostsPage extends StatefulWidget {
//   const PostsPage({super.key});
//
//   @override
//   _PostsPageState createState() => _PostsPageState();
// }
//
// class _PostsPageState extends State<PostsPage> {
//   late Future<List<Post>> _posts;
//
//   @override
//   void initState() {
//     super.initState();
//     _posts = fetchPosts();
//   }
//
//   Future<List<Post>> fetchPosts() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     if (response.statusCode == 200) {
//       Iterable list = json.decode(response.body);
//       return list.map((model) => Post.fromJson(model)).toList();
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Post>>(
//       future: _posts,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(snapshot.data![index].title),
//                 subtitle: Text(snapshot.data![index].body),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           CommentPage(post: snapshot.data![index]),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;
//
//   Album({required this.userId, required this.id, required this.title});
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

// class Post {
//   final int userId;
//   final int id;
//   final String title;
//   final String body;
//
//   Post(
//       {required this.userId,
//       required this.id,
//       required this.title,
//       required this.body});
//
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }
