import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  const UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<({List<UserEntity> users, Failure? failure})> getUsers() async {
    try {
      final models = await _remoteDataSource.getUsers();
      final entities = models.map((m) => m.toEntity()).toList();
      return (users: entities, failure: null);
    } on Failure catch (f) {
      return (users: <UserEntity>[], failure: f);
    } catch (_) {
      return (
        users: <UserEntity>[],
        failure: const ParseFailure(),
      );
    }
  }
}
