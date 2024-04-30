import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_sgx/screens/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AlbumProvider extends ChangeNotifier {
  List<Album> _albums = [];

  List<Album> get albums => _albums; //getter

  Future<void> fetchAlbums() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      _albums = list.map((model) => Album.fromJson(model)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load albums');
    }
  }
}

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlbumProvider(),
      child: _AlbumsPageContent(),
    );
  }
}

class _AlbumsPageContent extends StatefulWidget {
  const _AlbumsPageContent({Key? key});

  @override
  __AlbumsPageContentState createState() => __AlbumsPageContentState();
}

class __AlbumsPageContentState extends State<_AlbumsPageContent> {
  late Future<void> _fetchAlbumsFuture;

  @override
  void initState() {
    super.initState();
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    _fetchAlbumsFuture = albumProvider.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _fetchAlbumsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final albumProvider = Provider.of<AlbumProvider>(context);
            final albums = albumProvider.albums;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(albums[index].title),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}