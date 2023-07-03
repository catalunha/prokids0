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
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    AppAssets.image01,
                    width: context.appPercentWidth(50),
                  ),
                ),
                const SizedBox(height: 20),
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
                // Center(
                //   child: SizedBox(
                //     width: context.appPercentWidth(70),
                //     child: ElevatedButton(
                //       onPressed: () {
                //         context.goNamed(AppPage.anamneseInterview.name);
                //       },
                //       style: Theme.of(context)
                //           .elevatedButtonTheme
                //           .style
                //           ?.copyWith(
                //               padding: MaterialStateProperty.all(
                //                   const EdgeInsets.all(5))),
                //       child: const Text('Prosseguir'),
                //     ),
                //   ),
                // ),
                // Center(
                //   child: Container(
                //     padding: const EdgeInsets.all(10),
                //     color: AppColors.instance.color3,
                //     child: Form(
                //       autovalidateMode: AutovalidateMode.onUserInteraction,
                //       child: TextFormField(
                //         decoration: const InputDecoration(
                //           label: Text('Login'),
                //         ),
                //         validator: (value) => 'Erro...',
                //       ),
                //     ),
                //   ),
                // ),
                // Text('appScreenHeight: ${context.appScreenHeight}',
                //     style: GoogleFonts.aleo(
                //       color: AppColors.instance.color3,
                //       fontSize: 20,
                //       fontWeight: FontWeight.normal,
                //     )),
                // Text(
                //   'appScreenWidth: ${context.appScreenWidth}',
                //   style: AppTextStyle.instance.aleo18Regular
                //       .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // Text('appScreenShortestSide: ${context.appScreenShortestSide}'),
                // Container(
                //   width: context.appPercentWidth(20),
                //   height: context.appScreenHeight,
                //   color: AppColors.instance.color3,
                // )
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
