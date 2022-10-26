import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../api/auth.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Aluno Online"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: SizedBox(
                  height: 150,
                  child: Image.asset('assets/images/app_logo.png')),
            ),
          ),
          SignInButton(Buttons.Google, onPressed: () {
            Auth().signInWithGoogle();
          }, text: 'Entrar com Gmail')
        ],
      ),
    );
  }
}
