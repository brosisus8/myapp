// lib/features/home/presentation/bloc/post_state.dart
part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final PostEntity post;

  const PostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

class PostError extends PostState {
  final String message;

  const PostError({required this.message});

  @override
  List<Object> get props => [message];
}
