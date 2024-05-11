import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/screens/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  final _auth = FirebaseAuth.instance;

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
              _forgotPassword(context),
              _signUp(context),
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
          "SereniChat",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        )
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          onChanged: (value) {
            email = value;
          },
          decoration: InputDecoration(
            hintText: "email",
            hintStyle: const TextStyle(
              color: black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: lightShadedBlue,
            filled: true,
            prefixIcon: const Icon(Icons.email),
          ),
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: (value) {
            password = value;
          },
          decoration: InputDecoration(
            hintText: "password",
            hintStyle: const TextStyle(
              color: black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: lightShadedBlue,
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            try {
              final user = await _auth.signInWithEmailAndPassword(
                  email: email, password: password);
              if (user != null) {
                Navigator.pushNamed(context, "navPage");
              }
            } catch (e) {
              print(e);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: darkShadedBlue,
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              fontSize: 20,
              color: white,
            ),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: blue),
      ),
    );
  }

  _signUp(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: blue,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpPage()));
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: blue),
          ),
        )
      ],
    );
  }
}
