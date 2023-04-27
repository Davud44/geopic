import 'package:equatable/equatable.dart';

abstract class SelectImageState extends Equatable {}

class SelectImageInitial extends SelectImageState {
  @override
  List<Object?> get props => [];
}

class SelectImageSuccessState extends SelectImageState {
  final List<String> result;

  SelectImageSuccessState({required this.result});

  @override
  List<Object?> get props => [];
}
