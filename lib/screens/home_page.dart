import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_provider.dart';
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
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login())
                  );
                },
                icon: const Icon(Icons.logout),

            )
          ],
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
