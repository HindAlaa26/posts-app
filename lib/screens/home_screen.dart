import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_states.dart';
import 'post_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPostsEvent());
    print('FetchPostsEvent added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade200,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          print('Current state: $state');
          if (state is PostLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          } else if (state is PostLoadedState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: Colors.white60,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2))
                    ],
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(post.body),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostDetailScreen(postId: post.id)),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is PostErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No posts available'));
          }
        },
      ),
    );
  }
}
