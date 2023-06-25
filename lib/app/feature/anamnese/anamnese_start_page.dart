import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prokids0/app/feature/anamnese/controller/providers.dart';

import '../../routes.dart';

class AnamneseStartPage extends ConsumerWidget {
  const AnamneseStartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(initDBProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anamnese - Inicio'),
      ),
      body: db.when(data: (data) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Olá,',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Esta é uma breve pesquisa sobre as condições gerais de sua criança.',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Estas informações serão úteis para nossa equipe desenvolver o melhor trabalho neuro/motor em cada atividade',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'A seguir serão solicitados dados básicos de você e da criança.',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'E depois cada pergunta será feita uma após a outra',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Preencha corretamente e vá ate o final da pesquisa.',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Pode parecer grande mas é importante você concluir com qualidade.',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Então reserve um tempo para isto.',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Obrigado.',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Equipe da ProKids.',
                  style: TextStyle(fontSize: 18),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.goNamed(AppPage.anamneseInterview.name);
                    },
                    child: const Text('Prosseguir'),
                  ),
                )
              ],
            ),
          ),
        );
      }, error: (error, st) {
        return const Center(
          child: Text('DB Error'),
        );
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
