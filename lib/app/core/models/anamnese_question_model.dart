import 'package:freezed_annotation/freezed_annotation.dart';

import 'anamnese_group_model.dart';

part 'anamnese_question_model.freezed.dart';

@freezed
abstract class AnamneseQuestionModel with _$AnamneseQuestionModel {
  factory AnamneseQuestionModel({
    String? id,
    required String text,
    String? description,
    required String type,
    @Default(false) bool required,
    required AnamneseGroupModel anamneseGroup,
    @Default(true) bool isActive,
  }) = _AnamneseQuestionModel;
}
