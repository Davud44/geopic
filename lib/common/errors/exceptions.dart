import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}

class ConnectionException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}
