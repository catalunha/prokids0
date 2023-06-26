import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnamneseEndPage extends StatelessWidget {
  const AnamneseEndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anamnese - Fim'),
        automaticallyImplyLeading: false,
      ),
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
    );
  }
}
