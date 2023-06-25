import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../core/models/anamnese_people_model.dart';

class AnamnesePeopleEntity {
  static const String className = 'AnamnesePeople';
  static const String id = 'objectId';
  static const String createdAt = 'createdAt';
  static const String adultName = 'adultName';
  static const String adultPhone = 'adultPhone';
  static const String childName = 'childName';
  static const String childIsFemale = 'childIsFemale';
  static const String childBirthDate = 'childBirthDate';

  AnamnesePeopleModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    AnamnesePeopleModel model = AnamnesePeopleModel(
      id: parseObject.objectId!,
      createdAt: parseObject.createdAt!.toLocal(),
      adultName: parseObject.get(AnamnesePeopleEntity.adultName),
      adultPhone: parseObject.get(AnamnesePeopleEntity.adultPhone),
      childName: parseObject.get(AnamnesePeopleEntity.childName),
      childIsFemale: parseObject.get(AnamnesePeopleEntity.childIsFemale),
      childBirthDate: parseObject
          .get<DateTime>(AnamnesePeopleEntity.childBirthDate)!
          .toLocal(),
    );
    return model;
  }

  Future<ParseObject> toParse(AnamnesePeopleModel model) async {
    final parseObject = ParseObject(AnamnesePeopleEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(AnamnesePeopleEntity.adultName, model.adultName);
    parseObject.set(AnamnesePeopleEntity.adultPhone, model.adultPhone);
    parseObject.set(AnamnesePeopleEntity.childName, model.childName);
    parseObject.set(AnamnesePeopleEntity.childIsFemale, model.childIsFemale);
    parseObject.set<DateTime?>(
        AnamnesePeopleEntity.childBirthDate,
        DateTime(
          model.childBirthDate.year,
          model.childBirthDate.month,
          model.childBirthDate.day,
        ));
    return parseObject;
  }
}
