import 'package:dio/dio.dart';
import 'package:geopic/common/errors/exceptions.dart';
import 'package:geopic/common/network/network_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../models/openai_response_model.dart';

abstract class ProbabilityDataSource {
  Future<OpenAiResponseModel> getProbabilities(String prompt);
}

@Singleton(as: ProbabilityDataSource)
class ProbabilityDataSourceImpl extends ProbabilityDataSource {
  final NetworkManager _networkManager = GetIt.instance.get<NetworkManager>();

  @override
  Future<OpenAiResponseModel> getProbabilities(String prompt) async {
    Response response = await _networkManager
        .post('/completions', {"model": "text-davinci-003", "prompt": prompt});
    if (response.statusCode == 200) {
      return OpenAiResponseModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
