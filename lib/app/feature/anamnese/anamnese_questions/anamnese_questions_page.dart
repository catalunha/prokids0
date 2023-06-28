import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../controller/providers.dart';
import 'anamnese_answer_multiple.dart';
import 'anamnese_answer_number.dart';
import 'anamnese_answer_simple.dart';
import 'anamnese_answer_text.dart';
import 'anamnese_question_navigator.dart';
import '../controller/states.dart';

class AnamneseQuestionsPage extends ConsumerWidget with Loader, Messages {
  AnamneseQuestionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AnamneseQuestionsStatus>(anamneseQuestionsStatusStateProvider,
        (previous, next) async {
      if (next == AnamneseQuestionsStatus.error) {
        hideLoader(context);
        showMessageError(context, 'Erro ao salvar pesquisa');
      }
      if (next == AnamneseQuestionsStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        // context.pop(); //sai da pagina
        context.goNamed(AppPage.anamneseEnd.name);
      }
      if (next == AnamneseQuestionsStatus.loading) {
        showLoader(context);
      }
    });

    final questions = ref.watch(readAllQuestionsProvider);
    ref.watch(answerCurrentProvider);
    ref.watch(answeredProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas'),
        automaticallyImplyLeading: false,
      ),
      body: questions.when(
        data: (data) {
          final answerCurrent = ref.watch(answerCurrentProvider)!;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    answerCurrent.group,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      answerCurrent.text,
                      style:
                          const TextStyle(fontSize: 32, color: Colors.yellow),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Sua resposta'),
                  if (answerCurrent.type ==
                      AnamneseQuestionTypeStatus.simple.name)
                    const AnamneseAnswerSimple(),
                  if (answerCurrent.type ==
                      AnamneseQuestionTypeStatus.multiple.name)
                    const AnamneseAnswerMultiple(),
                  if (answerCurrent.type ==
                      AnamneseQuestionTypeStatus.text.name)
                    const AnamneseAnswerText(),
                  if (answerCurrent.type ==
                      AnamneseQuestionTypeStatus.numeric.name)
                    const AnamneseAnswerNumber(),
                  const SizedBox(height: 20),
                  const AnamneseQuestionNavigator(),
                ],
              ),
            ),
          );
        },
        error: (error, st) {
          return const Text('Erro em listar perguntas');
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
