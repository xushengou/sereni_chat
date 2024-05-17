import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Column(
      children: [
        Text(
          "SereniChat",
          style: Theme.of(context).textTheme.displayMedium,
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
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
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
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
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
          ),
          child: Text(
            "Login",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Forgot password?",
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  _signUp(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpPage()));
          },
          child: Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    );
  }
}
