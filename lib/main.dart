import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/my_app.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseFirestore.instance.collection('students_warings').doc().set({
  //   'student_id': 'YdviIbZRx1AbCbO4JpR9',
  //   'warning_id': 'a5j17GBNG1SSfMHBwHeM',
  //   'reading_date': '',
  // });
}
