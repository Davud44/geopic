import 'package:dartz/dartz.dart';
import 'package:geopic/common/errors/failure.dart';
import 'package:geopic/data/datasources/propbability_datasource.dart';
import 'package:geopic/data/models/openai_response_model.dart';
import 'package:geopic/domain/repositories/probability_repository.dart';
import 'package:injectable/injectable.dart';

import '../../common/errors/exceptions.dart';

@Singleton(as: ProbabilityRepository)
class ProbabilityRepositoryImpl extends ProbabilityRepository {
  final ProbabilityDataSource _probabilityDataSource;

  ProbabilityRepositoryImpl(this._probabilityDataSource);

  @override
  Future<Either<Failure, OpenAiResponseModel>> getProbabilities(
      String prompt) async {
    try {
      final response = await _probabilityDataSource.getProbabilities(prompt);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
