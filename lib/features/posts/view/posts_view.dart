import 'package:api_with_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final postBloc = PostsBloc();

  @override
  void initState() {
    postBloc.add(PostsInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: const Text('Posts')),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {
          if (state is PostAddedSuccessActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Post added successfully'),
                backgroundColor: Colors.green,
                duration: const Duration(milliseconds: 500),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsLoadingState:
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            case PostsErrorState:
              final errorState = state as PostsErrorState;
              return Center(
                child: Text(
                  errorState.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            case PostsLoadedSuccessState:
              final successState = state as PostsLoadedSuccessState;
              return ListView.builder(
                itemCount: successState.posts.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        successState.posts[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          postBloc.add(PostAddEvent());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
