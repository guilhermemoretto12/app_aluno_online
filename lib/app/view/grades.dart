import 'package:flutter/material.dart';

class Grades extends StatelessWidget {
  const Grades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notas e Frequência'),
        ),
        body: ListView());
  }
}
