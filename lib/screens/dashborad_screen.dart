import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(icon: Icon(Icons.person), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Test Candidate"),
              accountEmail: Text("+91 80-721-2646"),
              currentAccountPicture: CircleAvatar(child: Text("TC")),
            ),
            ListTile(leading: Icon(Icons.article), title: Text("Posts")),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
          ],
        ),
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null && provider.posts.isEmpty) {
            return Center(child: Text(provider.errorMessage!));
          }

          return Column(
            children: [
              if (provider.isOfflineMode)
                Container(
                  color: Colors.amber,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Text("You are offline. Showing cached data.", 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: provider.fetchPosts,
                  child: ListView.builder(
                    itemCount: provider.posts.length,
                    itemBuilder: (context, index) {
                      final post = provider.posts[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(child: Text(post.id.toString())),
                          title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}