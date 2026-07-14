import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';

abstract class HomeFeedState extends Equatable {
  const HomeFeedState();

  @override
  List<Object?> get props => [];
}

class HomeFeedInitial extends HomeFeedState {
  const HomeFeedInitial();
}

class HomeFeedLoading extends HomeFeedState {
  const HomeFeedLoading();
}

class HomeFeedLoaded extends HomeFeedState {
  final List<UserEntity> users;
  final int currentIndex;

  const HomeFeedLoaded({
    required this.users,
    this.currentIndex = 0,
  });

  HomeFeedLoaded copyWith({
    List<UserEntity>? users,
    int? currentIndex,
  }) {
    return HomeFeedLoaded(
      users: users ?? this.users,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  UserEntity? get currentUser =>
      currentIndex < users.length ? users[currentIndex] : null;

  bool get hasMore => currentIndex < users.length;

  @override
  List<Object?> get props => [users, currentIndex];
}

class HomeFeedEmpty extends HomeFeedState {
  const HomeFeedEmpty();
}

class HomeFeedError extends HomeFeedState {
  final Failure failure;

  const HomeFeedError(this.failure);

  String get message => failure.message;

  bool get isNetwork => failure is NetworkFailure;
  bool get isTimeout => failure is TimeoutFailure;

  @override
  List<Object?> get props => [failure];
}
