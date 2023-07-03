import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_assets.dart';
import '../utils/app_color.dart';
import '../utils/app_size.dart';
import '../utils/app_text.dart';

class AnamneseEndPage extends StatelessWidget {
  const AnamneseEndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Anamnese - Fim'),
        //   automaticallyImplyLeading: false,
        // ),
        body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Obrigado.',
                        style: AppTextStyle.instance.aleo18Regular
                            .copyWith(color: AppColors.instance.color1),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Não esqueça de confirmar com a secretaria seu próximo atendimento.',
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
              Center(
                child: Image.asset(
                  AppAssets.image01,
                  width: 200,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: context.appPercentWidth(80),
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Realizar outra anamnese'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        /*
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Obrigado.',
                style: TextStyle(fontSize: 18),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Realizar outra anamnese'),
                ),
              )
            ],
          ),
        ),
      ),
      */
        );
  }
}
