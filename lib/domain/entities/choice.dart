import 'package:equatable/equatable.dart';

class Choice extends Equatable {
  final String text;
  final int index;
  final String finishReason;

  const Choice({
    required this.text,
    required this.index,
    required this.finishReason,
  });

  @override
  List<Object?> get props => [text];
}
