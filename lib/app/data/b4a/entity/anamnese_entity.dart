import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_model.dart';

class AnamneseEntity {
  static const String className = 'Anamnese';
  static const String id = 'objectId';
  static const String name = 'name';
  static const String orderOfGroups = 'orderOfGroups';

  AnamneseModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final AnamneseModel model = AnamneseModel(
      id: parseObject.objectId!,
      name: parseObject.get(AnamneseEntity.name),
      orderOfGroups:
          parseObject.get<List<dynamic>>(AnamneseEntity.orderOfGroups) != null
              ? parseObject
                  .get<List<dynamic>>(AnamneseEntity.orderOfGroups)!
                  .map((e) => e.toString())
                  .toList()
              : [],
    );
    return model;
  }

  Future<ParseObject> toParse(AnamneseModel model) async {
    final parseObject = ParseObject(AnamneseEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(AnamneseEntity.name, model.name);
    parseObject.set(AnamneseEntity.orderOfGroups, model.orderOfGroups);
    return parseObject;
  }
}
