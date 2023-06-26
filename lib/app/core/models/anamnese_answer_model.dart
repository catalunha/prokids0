import 'package:freezed_annotation/freezed_annotation.dart';

import 'anamnese_people_model.dart';

part 'anamnese_answer_model.freezed.dart';

@freezed
abstract class AnamneseAnswerModel with _$AnamneseAnswerModel {
  factory AnamneseAnswerModel({
    String? id,
    AnamnesePeopleModel? people,
    required int order,
    required String group,
    required String text,
    required String type,
    required List<String> options,
    required List<String> answers,
  }) = _AnamneseAnswerModel;
}
