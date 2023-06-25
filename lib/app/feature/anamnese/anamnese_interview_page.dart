import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../routes.dart';
import '../utils/app_mixin_loader.dart';
import '../utils/app_mixin_messages.dart';
import '../utils/app_textformfield.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class AnamneseInterviewPage extends ConsumerStatefulWidget {
  const AnamneseInterviewPage({super.key});

  @override
  ConsumerState<AnamneseInterviewPage> createState() =>
      _AnamneseDataPageState();
}

class _AnamneseDataPageState extends ConsumerState<AnamneseInterviewPage>
    with Loader, Messages {
  final _formKey = GlobalKey<FormState>();
  final _adultNameTec = TextEditingController();
  final _adultPhoneTec = TextEditingController();
  final _childNameTec = TextEditingController();
  final dateFormat = DateFormat('dd/MM/y');

  @override
  void initState() {
    super.initState();
    _adultNameTec.text = "";
    _adultPhoneTec.text = "";
    _childNameTec.text = "";
  }

  @override
  void dispose() {
    _adultNameTec.dispose();
    _adultPhoneTec.dispose();
    _childNameTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AnamnesePeopleFormState>(anamnesePeopleFormProvider,
        (previous, next) async {
      if (next.status == AnamneseStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == AnamneseStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        // context.pop(); //sai da pagina
        Navigator.pop(context);
      }
      if (next.status == AnamneseStatus.loading) {
        showLoader(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados pessoais'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('Dados do Pai/Mãe/Responsável pela criança'),
                    AppTextFormField(
                      label: '* Nome completo',
                      controller: _adultNameTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória'),
                    ),
                    AppTextFormField(
                      label: '* Celular. Formato: DDDNUMERO',
                      controller: _adultPhoneTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória'),
                    ),
                    const Text('Dados da criança'),
                    AppTextFormField(
                      label: '* Nome completo',
                      controller: _childNameTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória'),
                    ),
                    SwitchListTile(
                      title: ref.watch(childIsFemaleProvider)
                          ? const Text('É uma menina !')
                          : const Text('É um menino !'),
                      value: ref.watch(childIsFemaleProvider),
                      onChanged: (value) {
                        ref.read(childIsFemaleProvider.notifier).toggle();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Data de nascimento:'),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime.now(),
                              );
                              ref
                                  .watch(childBirthDateProvider.notifier)
                                  .set(newDate);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.date_range),
                                const SizedBox(width: 10),
                                Text(ref.watch(childBirthDateProvider) != null
                                    ? dateFormat.format(
                                        ref.watch(childBirthDateProvider)!)
                                    : "Não informado"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      // onPressed: () {
                      //   context.goNamed(AppPage.anamneseAnswer.name);
                      // },
                      onPressed: () {
                        if (ref.read(childBirthDateProvider) == null) {
                          showMessageError(context,
                              'Por favor preencha a data de nascimento');
                          return;
                        }
                        final formValid =
                            _formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          ref
                              .read(anamnesePeopleFormProvider.notifier)
                              .submitForm(
                                adultName: _adultNameTec.text,
                                adultPhone: _adultPhoneTec.text,
                                childName: _childNameTec.text,
                              );
                        } else {
                          return;
                        }
                        context.goNamed(AppPage.anamneseAnswer.name);
                      },
                      child: const Text('Iniciar Questionário.'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
