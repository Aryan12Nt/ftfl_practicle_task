import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _repository;

  const GetUsersUseCase(this._repository);

  Future<({List<UserEntity> users, Failure? failure})> call() {
    return _repository.getUsers();
  }
}
