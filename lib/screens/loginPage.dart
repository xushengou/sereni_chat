import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/screens/signUpPage.dart';
import '../widgets/std_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late String email;
  late String password;

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
            color: secondary_color,
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
        ElevatedButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: shaded_blue,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: secondary_color,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
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
