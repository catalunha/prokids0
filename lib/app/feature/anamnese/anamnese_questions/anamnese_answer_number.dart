import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/providers.dart';

class AnamneseAnswerNumber extends ConsumerStatefulWidget {
  const AnamneseAnswerNumber({super.key});

  @override
  ConsumerState<AnamneseAnswerNumber> createState() =>
      _AnamneseAnswerNumberState();
}

class _AnamneseAnswerNumberState extends ConsumerState<AnamneseAnswerNumber> {
  final _txtTec = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final answered = ref.read(answeredProvider);
    _txtTec.text = answered.join(',');
  }

  var intBefore = -1;
  @override
  Widget build(BuildContext context) {
    final answered = ref.watch(answeredProvider);
    final index = ref.watch(indexCurrentProvider);
    if (intBefore != index) {
      _txtTec.text = answered.join(',');
      intBefore = index;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _txtTec,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // maxLines: 3,
            onChanged: (value) {
              ref.read(answeredProvider.notifier).set([value]);
            },
            keyboardType: const TextInputType.numberWithOptions(),
            // inputFormatters: <TextInputFormatter>[
            //   // FilteringTextInputFormatter.allow(RegExp(r'[+-\d+\.]+')),
            //   // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
          ),
          TextButton(
            onPressed: () {
              _txtTec.text = '';
              ref.read(answeredProvider.notifier).reset();
            },
            child: const Text('Limpar resposta'),
          ),
          Text(answered.join(','))
        ],
      ),
    );
  }
}
