import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'choice.dart';

class OpenAiResponse extends Equatable {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;

  const OpenAiResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
  });

  @override
  List<Object?> get props => [id];
}
