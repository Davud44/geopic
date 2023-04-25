import 'package:dartz/dartz.dart';
import 'package:geopic/common/errors/failure.dart';
import 'package:geopic/domain/entities/openai_response.dart';

abstract class ProbabilityRepository {
  Future<Either<Failure, List<OpenAiResponse>>> getProbabilities();
}
