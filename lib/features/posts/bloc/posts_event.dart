part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

final class PostsInitialEvent extends PostsEvent {}

final class PostAddEvent extends PostsEvent {}
