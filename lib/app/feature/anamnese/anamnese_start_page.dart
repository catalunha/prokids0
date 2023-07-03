import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_assets.dart';
import '../utils/app_color.dart';
import '../utils/app_size.dart';

import '../../routes.dart';
import '../utils/app_text.dart';
import 'controller/providers.dart';

class AnamneseStartPage extends ConsumerWidget {
  const AnamneseStartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(initDBProvider);
    return Scaffold(
      body: db.when(data: (data) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AppAssets.image01,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Olá, tudo bem?',
                            style: AppTextStyle.instance.aleo18Regular
                                .copyWith(color: AppColors.instance.color1),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Esta é uma longa, necessária e importante pesquisa sobre as condições gerais de sua criança.\nPreencha corretamente e vá até o final da pesquisa.\nEstes dados são importantes para as demais consultas e tratamentos.\nOtimizando os atendimentos e seus resultados a longo prazo.\nÉ imprescindível o preenchimento completo do questionário em até 24h de antecedência à consulta.\nAssim, nossa equipe multidisciplinar poderá analisar o contexto da criança e suas necessidades.\nEntão reserve um bom tempo, responda tudo com fidelidade e qualidade.\nObrigado.',
                            style: AppTextStyle.instance.aleo18Regular
                                .copyWith(color: AppColors.instance.color1),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Equipe ProKids.',
                    style: AppTextStyle.instance.acme20Bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: context.appPercentWidth(80),
                      child: ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppPage.anamneseInterview.name);
                        },
                        child: const Text('Prosseguir'),
                      ),
                    ),
                  ),
                ],
              ),
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
