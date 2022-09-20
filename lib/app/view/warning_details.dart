import 'package:app_aluno_online/app/my_app.dart';
import 'package:flutter/material.dart';

class WarningDetails extends StatelessWidget {
  final String title;
  final String description;

  const WarningDetails(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigate(String path) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(path);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aviso institucional'),
        leading: IconButton(
            onPressed: () => navigate(MyApp.warnings),
            icon: const Icon(Icons.arrow_back)),
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
