import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_users_usecase.dart';
import 'home_feed_event.dart';
import 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  final GetUsersUseCase _getUsersUseCase;

  HomeFeedBloc({required GetUsersUseCase getUsersUseCase})
      : _getUsersUseCase = getUsersUseCase,
        super(const HomeFeedInitial()) {
    on<FetchHomeFeed>(_onFetch);
    on<RefreshHomeFeed>(_onRefresh);
    on<SwipeCard>(_onSwipe);
  }

  Future<void> _onFetch(
    FetchHomeFeed event,
    Emitter<HomeFeedState> emit,
  ) async {
    emit(const HomeFeedLoading());
    await _loadUsers(emit);
  }

  Future<void> _onRefresh(
    RefreshHomeFeed event,
    Emitter<HomeFeedState> emit,
  ) async {
    // Keep current state visible during refresh, then reload
    await _loadUsers(emit);
  }

  Future<void> _loadUsers(Emitter<HomeFeedState> emit) async {
    final result = await _getUsersUseCase();

    if (result.failure != null) {
      emit(HomeFeedError(result.failure!));
      return;
    }

    if (result.users.isEmpty) {
      emit(const HomeFeedEmpty());
      return;
    }

    emit(HomeFeedLoaded(users: result.users, currentIndex: 0));
  }

  void _onSwipe(SwipeCard event, Emitter<HomeFeedState> emit) {
    final currentState = state;
    if (currentState is! HomeFeedLoaded) return;

    final nextIndex = currentState.currentIndex + 1;

    if (nextIndex >= currentState.users.length) {
      emit(const HomeFeedEmpty());
    } else {
      emit(currentState.copyWith(currentIndex: nextIndex));
    }
  }
}
