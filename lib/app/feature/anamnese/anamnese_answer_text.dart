import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';

class AnamneseAnswerText extends ConsumerStatefulWidget {
  const AnamneseAnswerText({super.key});

  @override
  ConsumerState<AnamneseAnswerText> createState() => _AnamneseAnswerTextState();
}

class _AnamneseAnswerTextState extends ConsumerState<AnamneseAnswerText> {
  final _txtTec = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final answerTypeText = ref.read(answerTypeTextProvider);
    _txtTec.text = answerTypeText;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _txtTec.text = '';
  }

  var intBefore = -1;
  @override
  Widget build(BuildContext context) {
    final answerTypeText = ref.watch(answerTypeTextProvider);
    final index = ref.watch(indexCurrentProvider);
    if (intBefore != index) {
      _txtTec.text = answerTypeText;
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
            maxLines: 3,
            onChanged: (value) {
              ref.read(answerTypeTextProvider.notifier).set(value);
            },
          ),
          TextButton(
            onPressed: () {
              _txtTec.text = '';
              ref.read(answerTypeTextProvider.notifier).set('');
            },
            child: const Text('Limpar resposta'),
          ),
          Text(answerTypeText)
        ],
      ),
    );
  }
}
