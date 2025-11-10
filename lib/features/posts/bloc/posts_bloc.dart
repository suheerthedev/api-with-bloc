import 'dart:async';

import 'package:api_with_bloc/features/posts/models/post_model.dart';
import 'package:api_with_bloc/features/posts/repos/posts_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialEvent>(_onInit);
    on<PostAddEvent>(_onAdd);
  }

  Future<void> _onInit(
    PostsInitialEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoadingState());

    List<PostModel> posts = await PostsRepo.fetchPosts();

    if (posts.isNotEmpty) {
      emit(PostsLoadedSuccessState(posts: posts));
    } else {
      emit(PostsErrorState(error: 'No posts found'));
    }
  }

  Future<void> _onAdd(PostAddEvent event, Emitter<PostsState> emit) async {
    bool isAdded = await PostsRepo.addPost(
      PostModel(userId: 1, id: 1, title: 'test', body: 'test'),
    );

    if (isAdded) {
      emit(PostAddedSuccessActionState());
    } else {
      emit(PostsErrorState(error: 'Failed to add post'));
    }
  }
}
