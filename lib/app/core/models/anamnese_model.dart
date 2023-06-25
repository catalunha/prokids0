import 'package:freezed_annotation/freezed_annotation.dart';

part 'anamnese_model.freezed.dart';

@freezed
abstract class AnamneseModel with _$AnamneseModel {
  factory AnamneseModel({
    String? id,
    required String name,
    @Default([]) List<String> orderOfGroups,
  }) = _AnamneseModel;
}
