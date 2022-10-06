import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Grades extends StatefulWidget {
  const Grades({Key? key}) : super(key: key);

  @override
  State<Grades> createState() => _GradesState();
}

class _GradesState extends State<Grades> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notas e Frequência'),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("grades")
              .where("student_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Text('Período: ' +
                      snapshot.data!.docs[index].get('period').toString() +
                      '\nMatéria: ' +
                      snapshot.data!.docs[index].get('discipline') +
                      '\nNota: ' +
                      snapshot.data!.docs[index].get('grade').toString() +
                      '\nAulas: ' +
                      snapshot.data!.docs[index].get('classes').toString() +
                      '\nFrequência: ' +
                      snapshot.data!.docs[index].get('frequency').toString() +
                      ' (${snapshot.data!.docs[index].get('frequency') * 100 / snapshot.data!.docs[index].get('classes')})%');
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
