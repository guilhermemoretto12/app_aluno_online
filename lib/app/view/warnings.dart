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
  late Future<QuerySnapshot<Map<String, dynamic>>> warnings;
  @override
  void initState() {
    super.initState();

    warnings = FirebaseFirestore.instance.collection("warnings").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Avisos da instituição'),
        ),
        // body: ListView.builder(
        //   itemCount: Warnings.lista.length,
        //   itemBuilder: (context, i) {
        //     var warning = Warnings.lista[i];
        //     return ListTile(
        //       minLeadingWidth: 30,
        //       leading: const Icon(Icons.warning_amber_rounded),
        //       title: Text((warning['title'] as String) +
        //           ' ' +
        //           (Warnings.lista.length - i).toString()),
        //       subtitle: Text(warning['date'] as String),
        //       trailing: (warning['read']) == true
        //           ? null
        //           : Positioned(
        //               child: Icon(Icons.brightness_1,
        //                   size: 8.0, color: Colors.yellow[700])),
        //       onTap: () =>
        //           Navigator.of(context).pushNamed(MyApp.warningDetails),
        //     );
        //   },
        // )
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          // inside the <> you enter the type of your stream
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
                    trailing: (snapshot.data!.docs[index].get('title')) == true
                        ? null
                        : Positioned(
                            child: Icon(Icons.brightness_1,
                                size: 8.0, color: Colors.yellow[700])),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WarningDetails(
                            title: snapshot.data!.docs[index].get('title'),
                            description: snapshot.data!.docs[index]
                                .get('description')))),
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
