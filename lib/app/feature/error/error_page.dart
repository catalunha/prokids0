import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorMsg;
  const ErrorPage({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Erro em rota'),
        ),
        body: Center(
          child: Text(errorMsg),
        ));
  }
}
