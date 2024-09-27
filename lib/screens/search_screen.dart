import 'package:flutter/material.dart';
import 'package:sample_api/utils/constants.dart';
import '../services/post_service.dart';
import '../models/post_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Post> posts = []; // List of Post objects fetched from the API
  List<Post> _filteredItems = []; // Filtered list based on search query
  bool isLoading = true; // To show a loader when posts are being fetched

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Fetch the posts when the screen is initialized

    _searchController.addListener(() {
      _filterItems(); // Filter items whenever the search query changes
    });
  }

  // Fetch posts using PostService
  Future<void> _fetchPosts() async {
    try {
      List<Post> fetchedPosts =
          await PostService().fetchAllPosts(); // Fetch posts using PostService
      setState(() {
        posts = fetchedPosts;
        _filteredItems = []; // Initially, show no posts until the user types
        isLoading = false;
      });
    } catch (e) {
      // Handle the error (e.g., show an error message)
      setState(() {
        isLoading = false;
      });
      print("Error fetching posts: $e");
    }
  }

  // Filter items based on the search query
  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredItems = []; // Show no posts when the search query is empty
      } else {
        _filteredItems = posts.where((post) {
          return post.title.toLowerCase().contains(query) ||
              post.content.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TWITTER_BLACK,
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loader while fetching posts
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search posts',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: _filteredItems.isEmpty
                        ? const Center(
                            child: Text(
                              'Type to search posts.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _filteredItems.length,
                            itemBuilder: (context, index) {
                              Post post = _filteredItems[index];
                              return Card(
                                color: Colors.grey[850],
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                    post.title,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    post.content,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
