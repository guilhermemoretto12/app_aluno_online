import 'package:flutter/material.dart';

import '../my_app.dart';

class Warnings extends StatelessWidget {
  const Warnings({Key? key}) : super(key: key);

  static final lista = [
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': false},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': false},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': false},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': true},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': true},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': true},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': true},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': true},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': true},
    {'title': 'Título do aviso', 'date': '25/05/2022', 'read': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Avisos da instituição'),
        ),
        body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, i) {
            var warning = lista[i];
            return ListTile(
              minLeadingWidth: 30,
              leading: const Icon(Icons.warning_amber_rounded),
              title:
                  Text((warning['title'] as String) + ' ' + (lista.length - i).toString()),
              subtitle: Text(warning['date'] as String),
              trailing: (warning['read']) == true
                  ? null
                  : Positioned(
                      child: Icon(Icons.brightness_1,
                          size: 8.0, color: Colors.yellow[700])),
              onTap: () => Navigator.of(context).pushNamed(MyApp.warningDetails),
            );
          },
        ));
  }
}
