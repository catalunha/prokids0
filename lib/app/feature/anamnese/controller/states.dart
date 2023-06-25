import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/anamnese_people_model.dart';

part 'states.freezed.dart';

enum AnswerTypeBooleanStatus { none, yes, no }

enum AnamneseStatus { initial, loading, success, error }

@freezed
abstract class AnamnesePeopleFormState with _$AnamnesePeopleFormState {
  factory AnamnesePeopleFormState({
    @Default(AnamneseStatus.initial) AnamneseStatus status,
    @Default('') String error,
    AnamnesePeopleModel? model,
  }) = _AnamnesePeopleFormState;
}
