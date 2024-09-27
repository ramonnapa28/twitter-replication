import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../utils/constants.dart';

class PostService {
  // Change the method to return the list of posts directly
  Future<List<Post>> fetchAllPosts() async {
    final response = await http.get(Uri.parse('$HOST/api/v1/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
