import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_answer_model.dart';
import 'anamnese_people_entity.dart';
import 'anamnese_question_entity.dart';

class AnamneseAnswerEntity {
  static const String className = 'AnamneseAnswer';
  static const String id = 'objectId';
  static const String people = 'people';
  static const String question = 'question';
  static const String answer = 'answer';

  AnamneseAnswerModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final question = AnamneseQuestionEntity()
        .toModel(parseObject.get(AnamneseAnswerEntity.question));
    final answer = parseObject.get(AnamneseAnswerEntity.answer);
    bool? answerBool;
    String? answerText;
    if (question.type == 'boolean') {
      answerBool = answer == 'true' ? true : false;
    }
    if (question.type == 'text') {
      answerText = answer;
    }
    if (question.type == 'numerical') {
      answerText = answer;
    }
    AnamneseAnswerModel model = AnamneseAnswerModel(
      id: parseObject.objectId!,
      people: parseObject.get(AnamneseAnswerEntity.people) != null
          ? AnamnesePeopleEntity()
              .toModel(parseObject.get(AnamneseAnswerEntity.people))
          : null,
      question: question,
      answerBool: answerBool,
      answerText: answerText,
    );
    return model;
  }

  Future<ParseObject> toParse(AnamneseAnswerModel model) async {
    final parseObject = ParseObject(AnamneseAnswerEntity.className);
    parseObject.objectId = model.id;

    if (model.people != null) {
      parseObject.set(
          AnamneseAnswerEntity.people,
          (ParseObject(AnamnesePeopleEntity.className)
                ..objectId = model.people!.id)
              .toPointer());
    }
    if (model.question != null) {
      parseObject.set(
          AnamneseAnswerEntity.question,
          (ParseObject(AnamneseQuestionEntity.className)
                ..objectId = model.question!.id)
              .toPointer());
    }
    if (model.answered) {
      if (model.answerBool != null) {
        parseObject.set(
            AnamneseAnswerEntity.answer, model.answerBool! ? 'true' : 'false');
      }
      if (model.answerText != null && model.answerText!.isNotEmpty) {
        parseObject.set(AnamneseAnswerEntity.answer, model.answerText);
      }
    }
    return parseObject;
  }
}
