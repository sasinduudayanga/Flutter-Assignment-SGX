import 'package:flutter/material.dart';
import 'package:flutter_assignment_sgx/screens/my_profile.dart';
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
              Tab(text: 'Albums', icon: Icon(Icons.album)),
              Tab(text: 'Posts', icon: Icon(Icons.document_scanner),),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                    child: Text('Flutter App')
                ),
              ),
              ListTile(
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyProfile(),
                      )
                  );
                },
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
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
