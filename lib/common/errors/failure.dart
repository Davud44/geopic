import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidPageFailure extends Failure {
  final String message;

  InvalidPageFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class NullParamFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class PositionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UsernameAlreadyUsedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class WrongLoginCredentialsFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class PaymentRequiredFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class BookingImpossibleFailure extends Failure {
  final String message;

  BookingImpossibleFailure({required this.message});

  @override
  List<Object?> get props => [];
}
