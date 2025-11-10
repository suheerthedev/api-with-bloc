part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

sealed class PostsActionState extends PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoadingState extends PostsState {}

final class PostsLoadedSuccessState extends PostsState {
  final List<PostModel> posts;

  PostsLoadedSuccessState({required this.posts});
}

final class PostsErrorState extends PostsState {
  final String error;
  PostsErrorState({required this.error});
}

// ActionStaes
final class PostAddedSuccessActionState extends PostsActionState {}
