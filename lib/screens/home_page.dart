import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'album_page.dart';
import 'login_page.dart';
import 'post_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key});

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
        body: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.isAuthenticated) {
              return const TabBarView(
                children: [
                  AlbumsPage(),
                  PostsPage(),
                ],
              );
            } else {
              return const Center(
                child: Text('Please login to view content'),
              );
            }
          },
        ),
      ),
    );
  }
}
