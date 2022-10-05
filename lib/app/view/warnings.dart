import 'package:app_aluno_online/app/view/warning_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../my_app.dart';

class Warnings extends StatefulWidget {
  const Warnings({Key? key}) : super(key: key);

  @override
  State<Warnings> createState() => _WarningsState();
}

class _WarningsState extends State<Warnings> {
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> warningsStudent = [];
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("students_warings")
        .where("student_id", isEqualTo: "YdviIbZRx1AbCbO4JpR9")
        .get()
        .then((value) => setState(() {
              warningsStudent = value.docs;
            }));
  }

  @override
  Widget build(BuildContext context) {
    void navigate(String path) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(path);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Avisos da instituição'),
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
                      title: const Text('Horários'),
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
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("warnings").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    minLeadingWidth: 30,
                    leading: const Icon(Icons.warning_amber_rounded),
                    title: Text(snapshot.data!.docs[index].get('title')),
                    subtitle: Text((snapshot.data!.docs[index]
                            .get('created_at')
                            .toDate() as DateTime)
                        .toIso8601String()
                        .split('T')[0]
                        .split('-')
                        .reversed
                        .join('/')),
                    trailing: warningsStudent.isNotEmpty
                        ? warningsStudent
                                .firstWhere((item) =>
                                    item.get("warning_id") ==
                                    snapshot.data!.docs[index].id)
                                .data()
                                .containsKey("read_at")
                            ? null
                            : Positioned(
                                child: Icon(Icons.brightness_1,
                                    size: 8.0, color: Colors.yellow[700]))
                        : null,
                    onTap: () {
                      if (!warningsStudent
                          .firstWhere((item) =>
                              item.get("warning_id") ==
                              snapshot.data!.docs[index].id)
                          .data()
                          .containsKey("read_at")) {
                        FirebaseFirestore.instance
                            .collection("students_warings")
                            .doc(warningsStudent
                                .firstWhere((item) =>
                                    item.get("warning_id") ==
                                    snapshot.data!.docs[index].id)
                                .reference
                                .id)
                            .update({"read_at": DateTime.now()})
                            .catchError((error) => print(error));
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WarningDetails(
                              title: snapshot.data!.docs[index].get('title'),
                              description: snapshot.data!.docs[index]
                                  .get('description'))));
                    },
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
