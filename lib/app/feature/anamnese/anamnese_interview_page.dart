import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../routes.dart';
import '../utils/app_assets.dart';
import '../utils/app_mixin_loader.dart';
import '../utils/app_mixin_messages.dart';
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
    _adultNameTec.text = '';
    _adultPhoneTec.text = '';
    _childNameTec.text = '';
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
      if (next.status == AnamneseQuestionsStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == AnamneseQuestionsStatus.success) {
        hideLoader(context); //sai do Dialog do loading
        // context.pop(); //sai da pagina
        Navigator.pop(context);
      }
      if (next.status == AnamneseQuestionsStatus.loading) {
        showLoader(context);
      }
    });
    final childBirthDate = ref.watch(childBirthDateProvider);
    var childBirthDateAgeText = '...';
    if (childBirthDate != null) {
      final childBirthDateAge =
          AgeCalculator.age(childBirthDate, today: DateTime.now());
      childBirthDateAgeText =
          '${childBirthDateAge.years} a, ${childBirthDateAge.months} m, ${childBirthDateAge.days} d';
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Dados pessoais'),
      //   automaticallyImplyLeading: false,
      // ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        child: Container(
                          width: 300,
                          height: 300,
                          color: Colors.red,
                        ),
                      ),
                      Positioned(
                        top: -15,
                        child: Container(
                          width: 250,
                          height: 250,
                          color: Colors.blue,
                        ),
                      ),

                      // Positioned(
                      //   right: 0,
                      //   top: -15,
                      //   child: Container(
                      //     width: 230,
                      //     height: 230,
                      //     color: Colors.yellow,
                      //   ),
                      // ),
                    ],
                  ),

                  // Stack(
                  //   children: [
                  //     Positioned(
                  //       child: Column(
                  //         children: [
                  //           const SizedBox(height: 10),
                  //           Text(
                  //             'Dados do Pai/Mãe/Responsável pela criança',
                  //             style: AppTextStyle.instance.aleo18Bold,
                  //           ),
                  //           AppTextFormField(
                  //             label: '* Nome completo',
                  //             controller: _adultNameTec,
                  //             validator: Validatorless.required(
                  //                 'Esta informação é obrigatória'),
                  //           ),
                  //           AppTextFormField(
                  //             label: '* Celular. Formato: DDDNUMERO',
                  //             controller: _adultPhoneTec,
                  //             validator: Validatorless.multiple(
                  //               [
                  //                 Validatorless.required(
                  //                     'Esta informação é obrigatória'),
                  //                 Validatorless.number(
                  //                     'Esta informação é apenas numérica'),
                  //               ],
                  //             ),
                  //           ),
                  //           Text(
                  //             'Dados da criança',
                  //             style: AppTextStyle.instance.aleo18Bold,
                  //           ),
                  //           AppTextFormField(
                  //             label: '* Nome completo',
                  //             controller: _childNameTec,
                  //             validator: Validatorless.required(
                  //                 'Esta informação é obrigatória'),
                  //           ),
                  //           SwitchListTile(
                  //             title: ref.watch(childIsFemaleProvider)
                  //                 ? const Text('É uma menina !')
                  //                 : const Text('É um menino !'),
                  //             value: ref.watch(childIsFemaleProvider),
                  //             onChanged: (value) {
                  //               ref
                  //                   .read(childIsFemaleProvider.notifier)
                  //                   .toggle();
                  //             },
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Wrap(
                  //               crossAxisAlignment: WrapCrossAlignment.center,
                  //               children: [
                  //                 const Text('Data de nascimento:'),
                  //                 const SizedBox(width: 10),
                  //                 Column(
                  //                   children: [
                  //                     TextButton(
                  //                       onPressed: () async {
                  //                         final DateTime? newDate =
                  //                             await showDatePicker(
                  //                           context: context,
                  //                           initialDate: DateTime.now(),
                  //                           firstDate: DateTime(
                  //                               DateTime.now().year - 100),
                  //                           lastDate: DateTime.now(),
                  //                         );
                  //                         ref
                  //                             .watch(childBirthDateProvider
                  //                                 .notifier)
                  //                             .set(newDate);
                  //                       },
                  //                       child: Row(
                  //                         mainAxisSize: MainAxisSize.min,
                  //                         children: [
                  //                           const Icon(Icons.date_range),
                  //                           const SizedBox(width: 10),
                  //                           Text(ref.watch(
                  //                                       childBirthDateProvider) !=
                  //                                   null
                  //                               ? dateFormat.format(ref.watch(
                  //                                   childBirthDateProvider)!)
                  //                               : 'Não informado'),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     if (ref.watch(childBirthDateProvider) !=
                  //                         null)
                  //                       Text(childBirthDateAgeText)
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Positioned(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           color: AppColors.instance.color2,
                  //         ),
                  //         padding: const EdgeInsets.all(10),
                  //         child: Text(
                  //           'Dados da Familia',
                  //           style: AppTextStyle.instance.aleo20Bold
                  //               .copyWith(color: AppColors.instance.colorWhite),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    // onPressed: () {
                    //   context.goNamed(AppPage.anamneseAnswer.name);
                    // },
                    onPressed: () {
                      if (ref.read(childBirthDateProvider) == null) {
                        showMessageError(
                            context, 'Por favor preencha a data de nascimento');
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
                      context.goNamed(AppPage.anamneseQuestions.name);
                    },
                    child: const Text('Iniciar Questionário.'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
