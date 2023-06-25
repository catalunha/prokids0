import 'package:freezed_annotation/freezed_annotation.dart';

import 'anamnese_people_model.dart';
import 'anamnese_question_model.dart';

part 'anamnese_answer_model.freezed.dart';

@freezed
abstract class AnamneseAnswerModel with _$AnamneseAnswerModel {
  factory AnamneseAnswerModel({
    String? id,
    AnamnesePeopleModel? people,
    AnamneseQuestionModel? question,
    @Default(false) bool answered,
    bool? answerBool,
    String? answerText,
  }) = _AnamneseAnswerModel;
}
