import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectionException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class PaymentRequiredException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class UsernameAlreadyUsedException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class WrongLoginCredentialsException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class BookingImpossibleException extends Equatable implements Exception {
  final String message;

  const BookingImpossibleException({required this.message});

  @override
  List<Object?> get props => [];
}
