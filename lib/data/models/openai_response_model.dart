import 'package:geopic/data/models/choice_model.dart';
import 'package:geopic/domain/entities/openai_response.dart';

class OpenAiResponseModel extends OpenAiResponse {
  const OpenAiResponseModel(
      {required super.id,
      required super.object,
      required super.created,
      required super.model,
      required super.choices});

  factory OpenAiResponseModel.fromJson(Map<String, dynamic> json) =>
      OpenAiResponseModel(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        choices: List<ChoiceModel>.from(
            json["choices"].map((x) => ChoiceModel.fromJson(x))),
      );
}
