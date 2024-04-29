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
