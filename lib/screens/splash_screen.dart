import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'login.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: const Image(image: AssetImage("assets/logo.png")),
      logoWidth: 100,
      // title: const Text(
      //   "Title",
      //   style: TextStyle(
      //     fontSize: 18,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      backgroundColor: const Color.fromARGB(255, 13, 21, 31),
      showLoader: true,
      loaderColor: const Color.fromARGB(255, 247, 226, 137),
      // loadingText: Text("Loading..."),
      navigator: const LoginPage(),
      durationInSeconds: 2,
    );
  }
}