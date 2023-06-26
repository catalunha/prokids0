import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/providers.dart';

class AnamneseAnswerSimple extends ConsumerWidget {
  const AnamneseAnswerSimple({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answered = ref.watch(answeredProvider);
    final answerCurrent = ref.watch(answerCurrentProvider)!;
    for (var item in answerCurrent.options) {
      print(item);
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var item in answerCurrent.options) ...[
              ElevatedButton(
                onPressed: () {
                  ref.read(answeredProvider.notifier).set([item]);
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
