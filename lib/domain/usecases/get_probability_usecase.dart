import 'package:dartz/dartz.dart';
import 'package:geopic/common/errors/failure.dart';
import 'package:geopic/domain/entities/openai_response.dart';
import 'package:geopic/domain/repositories/probability_repository.dart';
import 'package:geopic/domain/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProbabilityUseCase extends UseCase<OpenAiResponse, String> {
  final ProbabilityRepository _probabilityRepository;

  GetProbabilityUseCase(this._probabilityRepository);

  @override
  Future<Either<Failure, OpenAiResponse>> call(String params) async {
    return await _probabilityRepository.getProbabilities(params);
  }
}
