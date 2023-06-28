import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/anamnese_answer_model.dart';
import '../../../core/models/anamnese_group_model.dart';
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
    queryGroups.whereEqualTo(AnamneseGroupEntity.isActive, true);
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
        if (mapping.containsKey(groupId)) {
          listGroupsOrdened.add(mapping[groupId]!);
        }
      }
    } else {
      listGroupsOrdened = [...listGroups];
    }
    log('listGroupsOrdened: ${listGroupsOrdened.length}');
    // --- Listando Group
    // +++ Listando Question
    QueryBuilder<ParseObject> queryQuestions = QueryBuilder<ParseObject>(
        ParseObject(AnamneseQuestionEntity.className));
    queryQuestions.whereEqualTo(AnamneseQuestionEntity.isActive, true);
    final listQuestions =
        await ref.read(anamneseQuestionRepositoryProvider).list(
      queryQuestions,
      cols: {
        "${AnamneseQuestionEntity.className}.cols": [
          AnamneseQuestionEntity.text,
          AnamneseQuestionEntity.type,
          AnamneseQuestionEntity.options,
          AnamneseQuestionEntity.isActive,
          AnamneseQuestionEntity.isRequired,
          AnamneseQuestionEntity.group,
        ],
        "${AnamneseQuestionEntity.className}.pointers": [
          AnamneseQuestionEntity.group,
        ],
      },
    );
    var questionsOrdered = <AnamneseQuestionModel>[];
    for (var group in listGroupsOrdened) {
      final questionsUnOrdered = listQuestions
          .where((element) => element.group.id == group.id)
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
    log('questionsOrdered: ${questionsOrdered.length}');

    // --- Listando Question

    ref.read(indexEndProvider.notifier).set(questionsOrdered.length);
    final people = ref.read(anamnesePeopleFormProvider).model;
    ref.invalidate(indexCurrentProvider);

    var answers = <AnamneseAnswerModel>[];
    var order = 1;
    for (var question in questionsOrdered) {
      answers.add(AnamneseAnswerModel(
        people: people,
        order: order++,
        group: question.group.name,
        text: question.text,
        type: question.type,
        options: question.options,
        answers: [],
      ));
    }
    ref.read(answerCurrentProvider.notifier).set(answers[0]);
    return answers;
  }

  AnamneseAnswerModel getAnswer(int id) {
    return state.requireValue[id];
  }

  void updateAnswer(
    int id, {
    required List<String> answers,
  }) {
    List<AnamneseAnswerModel> list = [...state.requireValue];
    AnamneseAnswerModel temp = list[id];
    list.replaceRange(id, id + 1, [
      temp.copyWith(
        answers: answers,
      )
    ]);
    state = AsyncData([...list]);
  }

  void saveAnswers() async {
    ref
        .read(anamneseQuestionsStatusStateProvider.notifier)
        .set(AnamneseQuestionsStatus.loading);

    //+++ Salvando a ultima pergunta caso ela nao tenha sido previous
    final indexEnd = ref.read(indexEndProvider);
    final answered = ref.read(answeredProvider);
    ref.read(readAllQuestionsProvider.notifier).updateAnswer(
          indexEnd - 1,
          answers: answered,
        );
    //---

    try {
      final repo = ref.read(anamneseAnswerRepositoryProvider);
      var saves = <Future<String>>[];
      for (var answer in state.requireValue) {
        // if (answer.answers.isNotEmpty) {
        saves.add(repo.save(answer));
        // }
      }
      Future.wait(saves);
      ref
          .read(anamneseQuestionsStatusStateProvider.notifier)
          .set(AnamneseQuestionsStatus.success);
    } catch (e) {
      ref
          .read(anamneseQuestionsStatusStateProvider.notifier)
          .set(AnamneseQuestionsStatus.error);
    }
  }
}

@riverpod
class AnamneseQuestionsStatusState extends _$AnamneseQuestionsStatusState {
  @override
  AnamneseQuestionsStatus build() {
    return AnamneseQuestionsStatus.initial;
  }

  void set(AnamneseQuestionsStatus value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class AnswerCurrent extends _$AnswerCurrent {
  @override
  AnamneseAnswerModel? build() {
    return null;
  }

  void set(AnamneseAnswerModel value) {
    state = value;
  }
}

// @riverpod
// class AnswerTypeOptions extends _$AnswerTypeOptions {
//   @override
//   List<String> build() {
//     return [];
//   }

//   void set(List<String> value) {
//     state = value;
//   }
// }

@riverpod
class Answered extends _$Answered {
  @override
  List<String> build() {
    return [];
  }

  // void add(String value) {
  //   state = [...state, value];
  // }

  void set(List<String> value) {
    state = value;
  }

  void reset() {
    state = [];
  }

  // void remove(String value) {
  //   var temp = [...state];
  //   temp.remove(value);
  //   state = [...temp];
  // }

  void update(String value) {
    var temp = [...state];
    if (temp.contains(value)) {
      temp.remove(value);
    } else {
      temp.add(value);
    }
    state = [...temp];
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
      final answerCurrent =
          ref.read(readAllQuestionsProvider.notifier).getAnswer(state);
      ref.read(answerCurrentProvider.notifier).set(answerCurrent);
    }
  }

  void next() async {
    final indexEnd = ref.read(indexEndProvider);
    if (state < (indexEnd - 1)) {
      await _updateBeforeChangeIndex();
      state = state + 1;
      await _updateAfterChangeIndex();
      final answerCurrent =
          ref.read(readAllQuestionsProvider.notifier).getAnswer(state);
      ref.read(answerCurrentProvider.notifier).set(answerCurrent);
    }
  }

  Future<void> _updateBeforeChangeIndex() async {
    final answered = ref.read(answeredProvider);

    ref.read(readAllQuestionsProvider.notifier).updateAnswer(
          state,
          answers: answered,
        );

    ref.invalidate(answeredProvider);
  }

  Future<void> _updateAfterChangeIndex() async {
    final answerCurrent =
        ref.read(readAllQuestionsProvider.notifier).getAnswer(state);
    if (answerCurrent.answers.isNotEmpty) {
      ref.read(answeredProvider.notifier).set(answerCurrent.answers);
    } else {
      ref.invalidate(answeredProvider);
    }
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
    return false;
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
    state = state.copyWith(status: AnamneseQuestionsStatus.loading);
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
        status: AnamneseQuestionsStatus.success,
        model: anamnesePeopleTemp.copyWith(
          id: id,
        ),
      );
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AnamneseQuestionsStatus.error, error: 'Erro em editar cargo');
    }
  }
}

@riverpod
FutureOr<bool> initDB(InitDBRef ref) async {
  final InitBack4app initBack4app = InitBack4app();
  final bool initParse = await initBack4app.init();

  return initParse;
}
