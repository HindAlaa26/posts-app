import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/post_repository.dart';
import 'post_event.dart';
import 'post_states.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostLoadingState()) {
    on<FetchPostsEvent>(fetchPosts);

    on<FetchPostEvent>(fetchPost);
  }

  FutureOr<void> fetchPost(event, emit) async {
    emit(PostDetailsLoadingState());
    try {
      final post = await postRepository.fetchPost(event.id);
      final comments = await postRepository.fetchCommentsForPost(event.id);
      emit(PostDetailLoadedState(post, comments));
      print('Post loaded: ${post.title}');
      print('Comments loaded: ${comments.length}');
    } catch (e) {
      emit(PostDetailErrorState(e.toString()));
      print('Error loading post or comments: $e');
    }
  }

  FutureOr<void> fetchPosts(event, emit) async {
    emit(PostLoadingState());
    try {
      final posts = await postRepository.fetchPosts();
      emit(PostLoadedState(posts));
      print('Posts loaded: ${posts.length}');
    } catch (e) {
      emit(PostErrorState(e.toString()));
      print('Error loading posts: $e');
    }
  }
}
