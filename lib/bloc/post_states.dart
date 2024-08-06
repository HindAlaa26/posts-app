import 'package:data_from_api/models/comment_model.dart';
import 'package:data_from_api/models/post_model.dart';

sealed class PostState {}

final class PostLoadingState extends PostState {}

final class PostLoadedState extends PostState {
  final List<Post> posts;

  PostLoadedState(this.posts);
}

class PostErrorState extends PostState {
  final String message;

  PostErrorState(this.message);
}

// post details state

class PostDetailLoadedState extends PostState {
  final Post post;
  final List<Comment> comments;

  PostDetailLoadedState(this.post, this.comments);
}

final class PostDetailsLoadingState extends PostState {}

class PostDetailErrorState extends PostState {
  final String message;

  PostDetailErrorState(this.message);
}
