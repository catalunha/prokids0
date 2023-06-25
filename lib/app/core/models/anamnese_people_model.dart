import 'package:freezed_annotation/freezed_annotation.dart';

part 'anamnese_people_model.freezed.dart';

@freezed
abstract class AnamnesePeopleModel with _$AnamnesePeopleModel {
  factory AnamnesePeopleModel({
    String? id,
    DateTime? createdAt,
    required String adultName,
    required String adultPhone,
    required String childName,
    required DateTime childBirthDate,
    required bool childIsFemale,
  }) = _AnamnesePeopleModel;
}
