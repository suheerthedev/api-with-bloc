import 'dart:convert';
import 'dart:developer';

import 'package:api_with_bloc/features/posts/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
      );
      // log(response.body.toString());

      final decodedResponse = jsonDecode(response.body);

      final List<PostModel> posts = (decodedResponse as List<dynamic>)
          .map((e) => PostModel.fromJson(e))
          .toList();

      log(posts.length.toString());

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost(PostModel post) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );

    log(response.body.toString());

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }
}
