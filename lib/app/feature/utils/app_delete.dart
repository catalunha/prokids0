import 'package:flutter/material.dart';

class AppDelete extends StatelessWidget {
  final bool isVisible;
  final Function() action;
  const AppDelete({super.key, required this.isVisible, required this.action});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Text('Para apagar pressione por mais tempo!'),
                    );
                  },
                );
              },
              onLongPress: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          'Deseja realmente apagar definitivamente esta informação ? '),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              action();
                              Navigator.pop(context);
                            },
                            child: const Text('Sim')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Não'))
                      ],
                    );
                  },
                );
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ));
  }
}
