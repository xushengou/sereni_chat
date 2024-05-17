import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screens/home.dart';
import '../models/user_model.dart';
import 'login.dart';
import '../databases/database_handler.dart';
import 'package:project/themes.dart';

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
    return Column(
      children: [
        Text(
          "Sign Up",
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
            username = value;
            // _usernameController.text = value;
            // print(username);
          },
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "username",
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
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
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
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
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
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
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
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
                // update username (useful later!) >:)
                userCred.user!.updateDisplayName(_usernameController.text);
                print('Successfully created user');
                DatabaseHandler.createUser(UserModel(
                  firstName: "",
                  lastName: "",
                  cids: [],
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
          ),
          child: Text(
            "Sign Up",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ],
    );
  }

  _login(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    );
  }
}
