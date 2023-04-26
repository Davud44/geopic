import 'package:equatable/equatable.dart';
import 'package:geopic/domain/entities/openai_response.dart';

abstract class SelectImageState extends Equatable {}

class SelectImageInitial extends SelectImageState {
  @override
  List<Object?> get props => [];
}

class SelectImageSuccessState extends SelectImageState {
  final OpenAiResponse response;

  SelectImageSuccessState({required this.response});

  @override
  List<Object?> get props => [];
}
