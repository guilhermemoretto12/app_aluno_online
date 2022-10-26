import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

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
              .where("student_id",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .orderBy('period', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                  groupedArray = [];
              snapshot.data!.docs
                  .groupListsBy((element) => element.get("discipline"))
                  .forEach((key, value) {
                groupedArray.add(value);
              });
              return ListView.builder(
                itemCount: groupedArray.length,
                itemBuilder: (context, index) {
                  var disciplineGrades = groupedArray[index];
                  disciplineGrades
                      .sort((a, b) => a.get('period'));
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                topLeft: Radius.circular(4.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    disciplineGrades[0]
                                        .get('discipline')
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: disciplineGrades.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(height: 1);
                            },
                            itemBuilder: (context, index) {
                              var grade = disciplineGrades[index];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                      height: 60,
                                      child: Column(
                                        children: [
                                          const Text('Período'),
                                          Text(
                                            grade.get('period').toString() +
                                                '°',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                      )),
                                  SizedBox(
                                      height: 60,
                                      child: Column(
                                        children: [
                                          const Text('Nota'),
                                          Text(
                                            grade.get('grade').toString(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                      )),
                                  const SizedBox(
                                    height: 40,
                                    width: 0,
                                    child: VerticalDivider(
                                      width: 20,
                                      thickness: 0.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                      height: 60,
                                      child: Column(
                                        children: [
                                          const Text('Aulas'),
                                          Text(
                                            grade.get('classes').toString(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                      )),
                                  SizedBox(
                                      height: 60,
                                      child: Column(
                                        children: [
                                          const Text('Freq.'),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                grade
                                                    .get('frequency')
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                ' (${grade.get('frequency') * 100 / grade.get('classes')})%',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                      )),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
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
