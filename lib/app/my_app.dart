import 'package:flutter/material.dart';
import 'view/grades.dart';
import 'view/login.dart';
import 'view/schedule.dart';
import 'view/warnings.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const login = '/';
  static const grades = '/grades';
  static const schedule = '/schedule';
  static const warnings = '/warnings';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        login: (context) => const Login(),
        grades: (context) => const Grades(),
        schedule: (context) => const Schedule(),
        warnings: (context) => const Warnings(),
      },
    );
  }
}
