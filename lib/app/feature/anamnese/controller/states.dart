import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/anamnese_people_model.dart';

part 'states.freezed.dart';

enum AnamneseQuestionsStatus { initial, loading, success, error }

enum AnamneseQuestionTypeStatus { simple, multiple, text, numeric }

@freezed
abstract class AnamnesePeopleFormState with _$AnamnesePeopleFormState {
  factory AnamnesePeopleFormState({
    @Default(AnamneseQuestionsStatus.initial) AnamneseQuestionsStatus status,
    @Default('') String error,
    AnamnesePeopleModel? model,
  }) = _AnamnesePeopleFormState;
}
