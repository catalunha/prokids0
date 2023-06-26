import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_answer_model.dart';
import 'anamnese_people_entity.dart';

class AnamneseAnswerEntity {
  static const String className = 'AnamneseAnswer';
  static const String id = 'objectId';
  static const String people = 'people';
  static const String order = 'order';
  static const String group = 'group';
  static const String text = 'text';
  static const String type = 'type';
  static const String options = 'options';
  static const String answers = 'answers';

  AnamneseAnswerModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    AnamneseAnswerModel model = AnamneseAnswerModel(
      id: parseObject.objectId!,
      people: parseObject.get(AnamneseAnswerEntity.people) != null
          ? AnamnesePeopleEntity()
              .toModel(parseObject.get(AnamneseAnswerEntity.people))
          : null,
      order: parseObject.get(AnamneseAnswerEntity.order),
      group: parseObject.get(AnamneseAnswerEntity.group),
      text: parseObject.get(AnamneseAnswerEntity.text),
      type: parseObject.get(AnamneseAnswerEntity.type),
      options:
          parseObject.get<List<dynamic>>(AnamneseAnswerEntity.options) != null
              ? parseObject
                  .get<List<dynamic>>(AnamneseAnswerEntity.options)!
                  .map((e) => e.toString())
                  .toList()
              : [],
      answers:
          parseObject.get<List<dynamic>>(AnamneseAnswerEntity.answers) != null
              ? parseObject
                  .get<List<dynamic>>(AnamneseAnswerEntity.answers)!
                  .map((e) => e.toString())
                  .toList()
              : [],
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
    parseObject.set(AnamneseAnswerEntity.order, model.order);
    parseObject.set(AnamneseAnswerEntity.group, model.group);
    parseObject.set(AnamneseAnswerEntity.text, model.text);
    parseObject.set(AnamneseAnswerEntity.type, model.type);
    parseObject.set(AnamneseAnswerEntity.options, model.options);
    parseObject.set(AnamneseAnswerEntity.answers, model.answers);
    return parseObject;
  }
}
