import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_mixin_loader.dart';
import '../../utils/app_mixin_messages.dart';
import '../../utils/app_text.dart';
import '../controller/providers.dart';
import '../controller/states.dart';
import 'anamnese_answer_multiple.dart';
import 'anamnese_answer_number.dart';
import 'anamnese_answer_simple.dart';
import 'anamnese_answer_text.dart';
import 'anamnese_question_navigator.dart';

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
      // appBar: AppBar(
      //   title: const Text('Perguntas'),
      //   automaticallyImplyLeading: false,
      // ),
      body: questions.when(
        data: (data) {
          final answerCurrent = ref.watch(answerCurrentProvider)!;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        AppAssets.image01,
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 380,
                            maxHeight: 350,
                          ),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.instance.color3,
                                  ),
                                  width: 380,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          answerCurrent.text,
                                          style: AppTextStyle
                                              .instance.aleo18Regular,
                                        ),
                                      ),
                                      // const SizedBox(height: 20),
                                      // const AnamneseAnswerSimple(),
                                      // const AnamneseAnswerMultiple(),
                                      // const AnamneseAnswerNumber(),
                                      // const AnamneseAnswerText(),
                                      if (answerCurrent.type ==
                                          AnamneseQuestionTypeStatus
                                              .simple.name)
                                        const AnamneseAnswerSimple(),
                                      if (answerCurrent.type ==
                                          AnamneseQuestionTypeStatus
                                              .multiple.name)
                                        const AnamneseAnswerMultiple(),
                                      if (answerCurrent.type ==
                                          AnamneseQuestionTypeStatus.text.name)
                                        const AnamneseAnswerText(),
                                      if (answerCurrent.type ==
                                          AnamneseQuestionTypeStatus
                                              .numeric.name)
                                        const AnamneseAnswerNumber(),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.instance.color2,
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 5, bottom: 5),
                                  child: Text(
                                    answerCurrent.group,
                                    style: AppTextStyle.instance.aleo20Bold
                                        .copyWith(
                                            color:
                                                AppColors.instance.colorWhite),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AnamneseQuestionNavigator(),
/*
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
*/
                  ],
                ),
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
