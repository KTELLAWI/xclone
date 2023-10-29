// ignore_for_file: unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xclone_client/xclone_client.dart';
import 'package:xclone_flutter/blocks/feed/feed_event.dart';
import 'package:xclone_flutter/blocks/feed/feed_state.dart';
// import 'package:xclone_flutter/blocks/feed/feed_event.dart';
// import 'package:xclone_flutter/blocks/feed/feed_state.dart';

import '../../repositories/post_repository.dart';

// part 'feed_event.dart';
// part "feed_state.dart";

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository _postRepository;

  FeedBloc({
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        super(const FeedState()) {
    on<FeedLoadEvent>(_onLoadFeed);
    on<FeedCreatePostEvent>(_onCreatePost);
    on<FeedDeletePostEvent>(_onDeletePost);
  }

  Future<void> _onLoadFeed(
    FeedLoadEvent event,
    Emitter<FeedState> emit,
  ) async {
    emit(state.copyWith(status: FeedStatus.loading));
    try {
      final posts = await _postRepository.getAllPosts();
      emit(state.copyWith(status: FeedStatus.loaded, posts: posts));
    } catch (_) {
      emit(state.copyWith(status: FeedStatus.error));
    }
  }

  Future<void> _onCreatePost(
    FeedCreatePostEvent event,
    Emitter<FeedState> emit,
  ) async {
    try {
      await _postRepository.createPost(event.post);
      add(const FeedLoadEvent());
    } catch (_) {
      emit(state.copyWith(status: FeedStatus.error));
    }
  }

  Future<void> _onDeletePost(
    FeedDeletePostEvent event,
    Emitter<FeedState> emit,
  ) async {
    try {
      await _postRepository.deletePost(event.post);
      add(const FeedLoadEvent());
    } catch (_) {
      emit(state.copyWith(status: FeedStatus.error));
    }
  }
}