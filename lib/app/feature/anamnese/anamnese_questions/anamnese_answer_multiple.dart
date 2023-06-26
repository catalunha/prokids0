import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/providers.dart';

class AnamneseAnswerMultiple extends ConsumerWidget {
  const AnamneseAnswerMultiple({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answered = ref.watch(answeredProvider);
    final answerCurrent = ref.watch(answerCurrentProvider)!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var item in answerCurrent.options) ...[
              ElevatedButton(
                onPressed: () {
                  ref.read(answeredProvider.notifier).update(item);
                },
                style: ButtonStyle(
                  backgroundColor: answered.contains(item)
                      ? const MaterialStatePropertyAll<Color>(Colors.black)
                      : null,
                ),
                child: Text(item),
              ),
            ]
          ],
        ),
        TextButton(
          onPressed: () {
            ref.read(answeredProvider.notifier).reset();
          },
          child: const Text('Limpar resposta'),
        ),
      ],
    );
  }
}
