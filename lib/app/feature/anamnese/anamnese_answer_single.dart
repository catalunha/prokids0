import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'controller/states.dart';

class AnamneseAnswerSingle extends ConsumerWidget {
  const AnamneseAnswerSingle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerTypeBoolean = ref.watch(answerTypeBooleanProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref
                    .read(answerTypeBooleanProvider.notifier)
                    .set(AnswerTypeBooleanStatus.yes);
              },
              style: ButtonStyle(
                backgroundColor:
                    answerTypeBoolean == AnswerTypeBooleanStatus.yes
                        ? const MaterialStatePropertyAll<Color>(Colors.black)
                        : null,
              ),
              child: const Text('Sim'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(answerTypeBooleanProvider.notifier)
                    .set(AnswerTypeBooleanStatus.no);
              },
              style: ButtonStyle(
                backgroundColor: answerTypeBoolean == AnswerTypeBooleanStatus.no
                    ? const MaterialStatePropertyAll<Color>(Colors.black)
                    : null,
              ),
              child: const Text('Não'),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            ref
                .read(answerTypeBooleanProvider.notifier)
                .set(AnswerTypeBooleanStatus.none);
          },
          child: const Text('Limpar resposta'),
        ),
      ],
    );
  }
}
