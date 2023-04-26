import 'package:geopic/domain/entities/choice.dart';

class ChoiceModel extends Choice {
  const ChoiceModel(
      {required super.text, required super.index, required super.finishReason});

  factory ChoiceModel.fromJson(Map<String, dynamic> json) => ChoiceModel(
        text: json["text"],
        index: json["index"],
        finishReason: json["finish_reason"],
      );
}
