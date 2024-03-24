import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screens/homePage.dart';
import '../models/user_model.dart';
import 'loginPage.dart';
import '../databases/database_handler.dart';

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

  bool _validateUsername = false;
  bool _validateEmail = false;
  bool _validatePassword = false;

  bool _isUserCreating = false;
  TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

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
              _isUserCreating == true
                  ? CircularProgressIndicator()
                  : Container(),
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
        TextField(
          onChanged: (value) {
            username = value;
            // _usernameController.text = value;
            // print(username);
          },
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "username",
            hintStyle: const TextStyle(
              color: black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.shade100, //
            filled: true,
            prefixIcon: Icon(Icons.person),
            errorText: _validateUsername ? "Username Can't be Empty" : null,
          ),
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(height: 10),
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
            fillColor: Colors.blue.shade100, //
            filled: true,
            prefixIcon: Icon(Icons.email),
            errorText: _validateEmail ? "Email Can't be Empty" : null,
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
            fillColor: Colors.blue.shade100, //
            filled: true,
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: "re-enter password",
            hintStyle: const TextStyle(
              color: black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.shade100, //
            filled: true,
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            try {
              _auth
                  .createUserWithEmailAndPassword(
                email: email,
                password: password,
              ).then((userCred) {
                userCred.user!.updateDisplayName(_usernameController.text);
                print('Successfully created user');
                // _createUser();
                DatabaseHandler.createUser(UserModel(
                  firstName: "",
                  lastName: "",
                )).then((value) {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomePage()));
                });
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text(
            'Login',
            style: TextStyle(color: blue),
          ),
        )
      ],
    );
  }
}
