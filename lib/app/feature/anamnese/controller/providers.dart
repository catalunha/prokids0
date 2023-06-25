import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/anamnese_answer_model.dart';
import '../../../core/models/anamnese_group_model.dart';
import '../../../core/models/anamnese_model.dart';
import '../../../core/models/anamnese_people_model.dart';
import '../../../core/models/anamnese_question_model.dart';
import '../../../core/repositories/providers.dart';
import '../../../data/b4a/entity/anamnese_group_entity.dart';
import '../../../data/b4a/entity/anamnese_question_entity.dart';
import '../../../data/b4a/init_back4app.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class ReadAllQuestions extends _$ReadAllQuestions {
  @override
  FutureOr<List<AnamneseAnswerModel>> build() async {
    // +++ Listando Group
    QueryBuilder<ParseObject> queryGroups =
        QueryBuilder<ParseObject>(ParseObject(AnamneseGroupEntity.className));
    queryGroups.orderByAscending('name');
    final listGroups = await ref.read(anamneseGroupRepositoryProvider).list(
      queryGroups,
      cols: {
        "${AnamneseGroupEntity.className}.cols": [
          AnamneseGroupEntity.name,
          AnamneseGroupEntity.description,
          AnamneseGroupEntity.isActive,
          AnamneseGroupEntity.orderOfQuestions,
        ],
      },
    );
    var anamnese =
        await ref.read(anamneseRepositoryProvider).readByName('orderOfGroups');
    var listGroupsOrdened = <AnamneseGroupModel>[];
    if (anamnese != null && anamnese.orderOfGroups.isNotEmpty) {
      final Map<String, AnamneseGroupModel> mapping = {
        for (var group in listGroups) group.id!: group
      };
      for (var groupId in anamnese.orderOfGroups) {
        listGroupsOrdened.add(mapping[groupId]!);
      }
    } else {
      if (listGroups.isNotEmpty) {
        await ref.read(anamneseRepositoryProvider).save(AnamneseModel(
            name: 'orderOfGroups',
            orderOfGroups: listGroups.map((e) => e.id!).toList()));
      }

      listGroupsOrdened = [...listGroups];
    }

    // --- Listando Group
    // +++ Listando Question
    QueryBuilder<ParseObject> queryQuestions = QueryBuilder<ParseObject>(
        ParseObject(AnamneseQuestionEntity.className));
    queryQuestions.orderByAscending('text');
    final listQuestions =
        await ref.read(anamneseQuestionRepositoryProvider).list(
      queryQuestions,
      cols: {
        "${AnamneseQuestionEntity.className}.cols": [
          AnamneseQuestionEntity.text,
          AnamneseQuestionEntity.description,
          AnamneseQuestionEntity.type,
          AnamneseQuestionEntity.isActive,
          AnamneseQuestionEntity.isRequired,
          AnamneseQuestionEntity.anamneseGroup,
        ],
        "${AnamneseQuestionEntity.className}.pointers": [
          AnamneseQuestionEntity.anamneseGroup,
        ],
      },
    );
    var questionsOrdered = <AnamneseQuestionModel>[];
    for (var group in listGroupsOrdened) {
      final questionsUnOrdered = listQuestions
          .where((element) => element.anamneseGroup.id == group.id)
          .toList();

      if (group.orderOfQuestions.isNotEmpty) {
        final Map<String, AnamneseQuestionModel> mapping = {
          for (var question in questionsUnOrdered) question.id!: question
        };
        for (var questionId in group.orderOfQuestions) {
          if (mapping.containsKey(questionId)) {
            questionsOrdered.add(mapping[questionId]!);
          }
        }
      } else {
        questionsOrdered.addAll([...questionsUnOrdered]);
      }
    }
    // --- Listando Question

    ref.read(indexEndProvider.notifier).set(questionsOrdered.length);
    ref.read(questionCurrentProvider.notifier).set(questionsOrdered[0]);
    final people = ref.read(anamnesePeopleFormProvider).model;
    var answers = <AnamneseAnswerModel>[];
    for (var question in questionsOrdered) {
      answers.add(AnamneseAnswerModel(people: people, question: question));
    }
    ref.invalidate(indexCurrentProvider);
    return answers;
  }

  AnamneseAnswerModel getQuestion(int id) {
    return state.requireValue[id];
  }

  void updateAnswer(
    int id, {
    required bool answered,
    bool? answerBool,
    String? answerText,
  }) {
    log('updateAnswer.id: $id');
    log('updateAnswer.answered: $answered');
    log('updateAnswer.answerBool: $answerBool');
    log('updateAnswer.answerText: $answerText');
    List<AnamneseAnswerModel> list = [...state.requireValue];
    AnamneseAnswerModel temp = list[id];
    list.replaceRange(id, id + 1, [
      temp.copyWith(
        answered: answered,
        answerBool: answerBool,
        answerText: answerText,
      )
    ]);
    state = AsyncData([...list]);
  }

  void saveAnswers() async {
    ref
        .read(anamnesePeopleFormStatusStateProvider.notifier)
        .set(AnamneseStatus.loading);
    try {
      final repo = ref.read(anamneseAnswerRepositoryProvider);
      var saves = <Future<String>>[];
      for (var answer in state.requireValue) {
        if (answer.answered) {
          saves.add(repo.save(answer));
        }
      }
      Future.wait(saves);
      ref
          .read(anamnesePeopleFormStatusStateProvider.notifier)
          .set(AnamneseStatus.success);
    } catch (e) {
      ref
          .read(anamnesePeopleFormStatusStateProvider.notifier)
          .set(AnamneseStatus.error);
    }
  }
}

@riverpod
class AnamnesePeopleFormStatusState extends _$AnamnesePeopleFormStatusState {
  @override
  AnamneseStatus build() {
    return AnamneseStatus.initial;
  }

  void set(AnamneseStatus value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class QuestionCurrent extends _$QuestionCurrent {
  @override
  AnamneseQuestionModel? build() {
    return null;
  }

  void set(AnamneseQuestionModel value) {
    state = value;
  }
}

@riverpod
class AnswerTypeBoolean extends _$AnswerTypeBoolean {
  @override
  AnswerTypeBooleanStatus build() {
    return AnswerTypeBooleanStatus.none;
  }

  void set(AnswerTypeBooleanStatus value) {
    state = value;
  }
}

@riverpod
class AnswerTypeText extends _$AnswerTypeText {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class IndexEnd extends _$IndexEnd {
  @override
  int build() {
    return 0;
  }

  void set(int value) {
    state = value;
  }
}

@riverpod
bool canGoToIndexPrevious(CanGoToIndexPreviousRef ref) {
  return ref.watch(indexCurrentProvider) != 0;
}

@riverpod
bool inLastIndexCurrent(InLastIndexCurrentRef ref) {
  final indexEnd = ref.read(indexEndProvider);

  return ref.watch(indexCurrentProvider) == (indexEnd - 1);
}

@Riverpod(keepAlive: true)
class IndexCurrent extends _$IndexCurrent {
  @override
  int build() {
    return 0;
  }

  void previous() async {
    if (state > 0) {
      await _updateBeforeChangeIndex();
      state = state - 1;
      await _updateAfterChangeIndex();
      final questionCurrent =
          ref.read(readAllQuestionsProvider.notifier).getQuestion(state);
      ref.read(questionCurrentProvider.notifier).set(questionCurrent.question!);
    }
  }

  void next() async {
    final indexEnd = ref.read(indexEndProvider);
    if (state < (indexEnd - 1)) {
      await _updateBeforeChangeIndex();

      state = state + 1;
      await _updateAfterChangeIndex();
      final questionCurrent2 =
          ref.read(readAllQuestionsProvider.notifier).getQuestion(state);
      ref
          .read(questionCurrentProvider.notifier)
          .set(questionCurrent2.question!);
    }
  }

  Future<void> _updateBeforeChangeIndex() async {
    final answerTypeBoolean = ref.read(answerTypeBooleanProvider);
    final answerTypeText = ref.read(answerTypeTextProvider);

    if (answerTypeBoolean != AnswerTypeBooleanStatus.none ||
        answerTypeText.isNotEmpty) {
      if (answerTypeBoolean != AnswerTypeBooleanStatus.none) {
        ref.read(readAllQuestionsProvider.notifier).updateAnswer(state,
            answered: true,
            answerBool: answerTypeBoolean == AnswerTypeBooleanStatus.yes
                ? true
                : false);
      }
      if (answerTypeText.isNotEmpty) {
        ref
            .read(readAllQuestionsProvider.notifier)
            .updateAnswer(state, answered: true, answerText: answerTypeText);
      }
    } else {
      ref.read(readAllQuestionsProvider.notifier).updateAnswer(state,
          answered: false, answerBool: null, answerText: null);
    }
    ref.invalidate(answerTypeBooleanProvider);
    ref.invalidate(answerTypeTextProvider);

    final questionCurrent =
        ref.read(readAllQuestionsProvider.notifier).getQuestion(state);
    log('_updateBeforeChangeIndex questionCurrent[$state]: $questionCurrent');
  }

  Future<void> _updateAfterChangeIndex() async {
    final questionCurrent =
        ref.read(readAllQuestionsProvider.notifier).getQuestion(state);
    if (questionCurrent.answered) {
      if (questionCurrent.answerBool != null) {
        ref.read(answerTypeBooleanProvider.notifier).set(
            questionCurrent.answerBool!
                ? AnswerTypeBooleanStatus.yes
                : AnswerTypeBooleanStatus.no);
      }
      if (questionCurrent.answerText != null) {
        ref
            .read(answerTypeTextProvider.notifier)
            .set(questionCurrent.answerText!);
      }
    } else {
      ref.invalidate(answerTypeBooleanProvider);
      ref.invalidate(answerTypeTextProvider);
    }
    final answerTypeBoolean = ref.read(answerTypeBooleanProvider);
    final answerTypeText = ref.read(answerTypeTextProvider);
    log('answerTypeBoolean: $answerTypeBoolean');
    log('answerTypeText: $answerTypeText');
  }
}

@riverpod
class ChildBirthDate extends _$ChildBirthDate {
  @override
  DateTime? build() {
    return null;
  }

  void set(DateTime? value) {
    state = value;
  }
}

@riverpod
class ChildIsFemale extends _$ChildIsFemale {
  @override
  bool build() {
    return true;
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class AnamnesePeopleForm extends _$AnamnesePeopleForm {
  @override
  AnamnesePeopleFormState build() {
    return AnamnesePeopleFormState();
  }

  Future<void> submitForm({
    required String adultName,
    required String adultPhone,
    required String childName,
  }) async {
    state = state.copyWith(status: AnamneseStatus.loading);
    try {
      final childIsFemale = ref.read(childIsFemaleProvider);
      final childBirthDate = ref.read(childBirthDateProvider);

      final anamnesePeopleTemp = AnamnesePeopleModel(
        adultName: adultName,
        adultPhone: adultPhone,
        childName: childName,
        childIsFemale: childIsFemale,
        childBirthDate: childBirthDate!,
      );

      final id = await ref
          .read(anamnesePeopleRepositoryProvider)
          .save(anamnesePeopleTemp);

      state = state.copyWith(
        status: AnamneseStatus.success,
        model: anamnesePeopleTemp.copyWith(
          id: id,
        ),
      );
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseStatus.error, error: 'Erro em editar cargo');
    }
  }
}

@riverpod
FutureOr<bool> initDB(InitDBRef ref) async {
  final InitBack4app initBack4app = InitBack4app();
  final bool initParse = await initBack4app.init();

  return initParse;
}
