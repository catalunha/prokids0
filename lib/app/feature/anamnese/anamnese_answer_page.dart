import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes.dart';
import '../utils/app_mixin_loader.dart';
import '../utils/app_mixin_messages.dart';
import 'anamnese_text.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class AnamneseAnswerPage extends ConsumerWidget with Loader, Messages {
  AnamneseAnswerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AnamneseStatus>(anamnesePeopleFormStatusStateProvider,
        (previous, next) async {
      if (next == AnamneseStatus.error) {
        hideLoader(context);
        showMessageError(context, 'Erro ao salvar pesquisa');
      }
      if (next == AnamneseStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        // context.pop(); //sai da pagina
        context.goNamed(AppPage.anamneseEnd.name);
      }
      if (next == AnamneseStatus.loading) {
        showLoader(context);
      }
    });

    final questions = ref.watch(readAllQuestionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pergunta'),
      ),
      body: questions.when(
        data: (data) {
          return const Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnamneseText(),
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
