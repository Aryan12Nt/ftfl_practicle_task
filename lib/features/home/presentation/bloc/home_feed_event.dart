import 'package:equatable/equatable.dart';

abstract class HomeFeedEvent extends Equatable {
  const HomeFeedEvent();

  @override
  List<Object?> get props => [];
}

class FetchHomeFeed extends HomeFeedEvent {
  const FetchHomeFeed();
}

class RefreshHomeFeed extends HomeFeedEvent {
  const RefreshHomeFeed();
}

class SwipeCard extends HomeFeedEvent {
  final int index;
  final bool isLike;

  const SwipeCard({required this.index, required this.isLike});

  @override
  List<Object?> get props => [index, isLike];
}
