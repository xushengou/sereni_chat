import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screens/homePage.dart';

import '../widgets/std_text_field.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _auth = FirebaseAuth.instance;
  String username = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _logoName(context),
              _inputField(context),
              _login(context),
            ],
          ),
        ),
      ),
    );
  }

  _logoName(context) {
    return const Column(
      children: [
        Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        StdTextField(
          returnValue: username,
          hintText: "username",
          textIcon: Icons.person,
          obscure: false,
        ),

        const SizedBox(height: 10),
        StdTextField(
          returnValue: email,
          hintText: "email",
          textIcon: Icons.email,
          obscure: false,
        ),

        const SizedBox(height: 10),
        StdTextField(
          returnValue: password,
          hintText: "password",
          textIcon: Icons.lock,
          obscure: false,
        ),

        const SizedBox(height: 10),
        StdTextField(
          returnValue: password,
          hintText: "re-enter password",
          textIcon: Icons.lock,
          obscure: true,
        ),

        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async{
            try {
              FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              ).then((_) {
                print('Successfully created user');
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              });
            } catch (e) {
              print(e);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: shaded_blue,
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 20, color: secondary_color),
          ),
        )
      ],
    );
  }

  _login(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(
            color: blue,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text(
            'Login',
            style: TextStyle(color: blue),
          ),
        )
      ],
    );
  }
