import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'anamnese_answer_repository.dart';
import 'anamnese_group_repository.dart';
import 'anamnese_people_repository.dart';
import 'anamnese_question_repository.dart';
import 'anamnese_repository.dart';

part 'providers.g.dart';

@riverpod
AnamneseGroupRepository anamneseGroupRepository(
    AnamneseGroupRepositoryRef ref) {
  return AnamneseGroupRepository();
}

@riverpod
AnamneseQuestionRepository anamneseQuestionRepository(
    AnamneseQuestionRepositoryRef ref) {
  return AnamneseQuestionRepository();
}

@riverpod
AnamneseRepository anamneseRepository(AnamneseRepositoryRef ref) {
  return AnamneseRepository();
}

@riverpod
AnamnesePeopleRepository anamnesePeopleRepository(
    AnamnesePeopleRepositoryRef ref) {
  return AnamnesePeopleRepository();
}

@riverpod
AnamneseAnswerRepository anamneseAnswerRepository(
    AnamneseAnswerRepositoryRef ref) {
  return AnamneseAnswerRepository();
}
