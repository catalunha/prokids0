import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'anamnese_answer_navigator.dart';
import 'anamnese_answer_number.dart';
import 'anamnese_answer_single.dart';
import 'anamnese_answer_text.dart';
import 'controller/providers.dart';

class AnamneseText extends ConsumerWidget {
  const AnamneseText({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionCurrent = ref.watch(questionCurrentProvider)!;
    ref.watch(answerTypeBooleanProvider);
    ref.watch(answerTypeTextProvider);

    return Column(
      children: [
        Text(questionCurrent.anamneseGroup.name),
        Text(questionCurrent.text),
        if (questionCurrent.type == 'boolean') const AnamneseAnswerSingle(),
        if (questionCurrent.type == 'text') const AnamneseAnswerText(),
        if (questionCurrent.type == 'numerical') const AnamneseAnswerNumber(),
        const AnamneseAnswerNavigator(),
      ],
    );
  }
}
