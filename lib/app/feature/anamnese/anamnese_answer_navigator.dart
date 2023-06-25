import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';

class AnamneseAnswerNavigator extends ConsumerWidget {
  const AnamneseAnswerNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexCurrent = ref.watch(indexCurrentProvider);
    final canGoToIndexPrevious = ref.watch(canGoToIndexPreviousProvider);
    final inLastIndexCurrent = ref.watch(inLastIndexCurrentProvider);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: canGoToIndexPrevious
                    ? () {
                        ref.read(indexCurrentProvider.notifier).previous();
                      }
                    : null,
                child: const Text('previous'),
              ),
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: inLastIndexCurrent
                    ? null
                    : () {
                        ref.read(indexCurrentProvider.notifier).next();
                      },
                child: const Text('next'),
              ),
            ),
          ],
        ),
        inLastIndexCurrent
            ? SizedBox(
                width: 240,
                child: ElevatedButton(
                  onPressed: canGoToIndexPrevious
                      ? () {
                          ref
                              .read(readAllQuestionsProvider.notifier)
                              .saveAnswers();
                          // final isCorrectAnsStudent = ref
                          //     .read(indexCurrentProvider.notifier)
                          //     .beforeUpdateState();
                          // if (isCorrectAnsStudent) {
                          //   ref
                          //       .read(timerResolutionProvider.notifier)
                          //       .stopResolution();
                          //   context.goNamed(AppPage.calcReport.name);
                          // }
                        }
                      : null,
                  child: const Text('finish'),
                ),
              )
            : const SizedBox.shrink(),
        Text('indexCurrent: $indexCurrent'),
      ],
    );
  }
}
