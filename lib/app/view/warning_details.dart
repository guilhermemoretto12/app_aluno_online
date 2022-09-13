import 'package:flutter/material.dart';

class WarningDetails extends StatelessWidget {
  final String title;
  final String description;

  const WarningDetails(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aviso institucional'),
      ),
      body: Column(children: [
        Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
        ),
        Padding(
            padding:
                const EdgeInsets.only(top: 24, bottom: 16, left: 16, right: 16),
            child: Text(description, textAlign: TextAlign.justify))
      ]),
    );
  }
}
