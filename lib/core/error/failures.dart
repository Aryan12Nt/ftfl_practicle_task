import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error. Please try again.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure(
      [super.message = 'No internet connection. Please check your network.']);
}

class ParseFailure extends Failure {
  const ParseFailure([super.message = 'Failed to parse server response.']);
}

class EmptyFailure extends Failure {
  const EmptyFailure([super.message = 'No profiles found.']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Request timed out. Please retry.']);
}
