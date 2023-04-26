import 'package:equatable/equatable.dart';

abstract class SelectImageEvent extends Equatable {}

class SendDetectPlaceRequest extends SelectImageEvent {
  final String prompt;

  SendDetectPlaceRequest({required this.prompt});

  @override
  List<Object?> get props => [];
}
