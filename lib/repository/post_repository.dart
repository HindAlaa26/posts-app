import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../models/comment_model.dart';

class PostRepository {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Post> posts =
          body.map((dynamic item) => Post.fromJson(item)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPost(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id'));
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Comment>> fetchCommentsForPost(int postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/comments?postId=$postId'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Comment> comments =
          body.map((dynamic item) => Comment.fromJson(item)).toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
