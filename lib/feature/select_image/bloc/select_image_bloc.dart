import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic/common/errors/failure.dart';
import 'package:geopic/domain/entities/openai_response.dart';
import 'package:geopic/feature/select_image/bloc/select_image_event.dart';
import 'package:geopic/feature/select_image/bloc/select_image_state.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_probability_usecase.dart';

@injectable
class SelectImageBloc extends Bloc<SelectImageEvent, SelectImageState> {
  final GetProbabilityUseCase _getProbabilityUseCase;

  SelectImageBloc(this._getProbabilityUseCase) : super(SelectImageInitial()) {
    on<SendDetectPlaceRequest>(_getProbabilities);
  }

  _getProbabilities(SendDetectPlaceRequest event, emit) async {
    Either<Failure, OpenAiResponse> response =
        await _getProbabilityUseCase.call(event.prompt);
    response.fold((l) => null, (OpenAiResponse openAiResponse) {
      emit(SelectImageSuccessState(response: openAiResponse));
    });
  }
}
