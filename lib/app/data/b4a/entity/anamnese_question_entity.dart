import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_question_model.dart';
import 'anamnese_group_entity.dart';

class AnamneseQuestionEntity {
  static const String className = 'AnamneseQuestion';
  static const String id = 'objectId';
  static const String text = 'text';
  static const String description = 'description';
  static const String type = 'type';
  static const String isRequired = 'isRequired';
  static const String anamneseGroup = 'anamneseGroup';
  static const String isActive = 'isActive';

  AnamneseQuestionModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    AnamneseQuestionModel model = AnamneseQuestionModel(
      id: parseObject.objectId!,
      text: parseObject.get(AnamneseQuestionEntity.text),
      description: parseObject.get(AnamneseQuestionEntity.description),
      type: parseObject.get(AnamneseQuestionEntity.type),
      required: parseObject.get<bool>(AnamneseQuestionEntity.isRequired,
          defaultValue: false)!,
      anamneseGroup: AnamneseGroupEntity().toModel(
          parseObject.get(AnamneseQuestionEntity.anamneseGroup),
          cols: cols),
      isActive: parseObject.get<bool>(AnamneseQuestionEntity.isActive,
          defaultValue: true)!,
    );
    return model;
  }

  Future<ParseObject> toParse(AnamneseQuestionModel model) async {
    final parseObject = ParseObject(AnamneseQuestionEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(AnamneseQuestionEntity.text, model.text);
    if (model.description != null) {
      parseObject.set(AnamneseQuestionEntity.description, model.description);
    }
    parseObject.set(AnamneseQuestionEntity.type, model.type);
    parseObject.set(AnamneseQuestionEntity.isRequired, model.required);
    parseObject.set(
        AnamneseQuestionEntity.anamneseGroup,
        (ParseObject(AnamneseGroupEntity.className)
              ..objectId = model.anamneseGroup.id)
            .toPointer());
    parseObject.set(AnamneseQuestionEntity.isActive, model.isActive);
    return parseObject;
  }
}
