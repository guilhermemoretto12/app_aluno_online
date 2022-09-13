import 'package:flutter/material.dart';

import '../my_app.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigate(String path) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(path);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Aluno Online'),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ListView(
                  children: [
                    const SizedBox(
                        height: 64,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text('Nome do acadêmico - 00000000',
                              style: TextStyle(color: Colors.white)),
                        )),
                    ListTile(
                      leading: const Icon(Icons.calendar_month_outlined),
                      minLeadingWidth: 30,
                      title: const Text('Horário de aula'),
                      onTap: () => navigate(MyApp.schedule),
                    ),
                    ListTile(
                      leading: const Icon(Icons.school_outlined),
                      minLeadingWidth: 30,
                      title: const Text('Notas e Frequência'),
                      onTap: () => navigate(MyApp.grades),
                    ),
                    ListTile(
                      leading: const Icon(Icons.warning_amber_rounded),
                      minLeadingWidth: 30,
                      title: const Text('Avisos da Instituição'),
                      onTap: () => navigate(MyApp.warnings),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                minLeadingWidth: 30,
                title: const Text('Sair'),
                onTap: () => navigate(MyApp.login),
              )
            ],
          ),
        ),
        body: ListView());
  }
}
