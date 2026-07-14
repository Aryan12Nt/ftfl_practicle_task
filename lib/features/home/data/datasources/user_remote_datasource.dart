import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;

  const UserRemoteDataSourceImpl(this._dio);

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response =
          await _dio.get('/api/', queryParameters: {'results': 20});

      if (response.statusCode != 200) {
        throw ServerFailure('Unexpected status: ${response.statusCode}');
      }

      final data = response.data;
      if (data == null || data['results'] == null) {
        throw const ParseFailure();
      }

      final results = data['results'] as List<dynamic>;
      return results
          .asMap()
          .entries
          .map((e) => UserModel.fromJson(
                e.value as Map<String, dynamic>,
                e.key,
              ))
          .toList();
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const TimeoutFailure();
        case DioExceptionType.connectionError:
          throw const NetworkFailure();
        default:
          throw ServerFailure(e.message ?? 'Server error');
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw const ParseFailure();
    }
  }
}
