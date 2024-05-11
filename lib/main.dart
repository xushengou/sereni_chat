import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/color_const.dart';
import 'package:project/screens/Navbar.dart';
import 'package:project/screens/gratefulness.dart';
import 'package:project/screens/login.dart';
import 'package:project/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: darkTheme1,
        ),
      ),
      initialRoute: 'loginPage',
      routes: {
        'loginPage': (context) => const LoginPage(),
        'signUpPage': (context) => const SignUpPage(),
        'gratefulnessPage': (context) => const GratefulnessPage(),
        'navPage': (context) => const Navbar(),
      },
    );
  }
}
