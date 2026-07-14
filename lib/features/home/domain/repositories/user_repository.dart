import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  /// Fetches a fresh batch of 20 random user profiles.
  /// Returns a [Failure] on any error, or the list on success.
  Future<({List<UserEntity> users, Failure? failure})> getUsers();
}
