import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/screens/chatNavScreen.dart';
import 'package:project/screens/chatPage.dart';
import 'package:project/screens/gratefulnessPage.dart';
import 'package:project/screens/homePage.dart';
import 'package:project/screens/loginPage.dart';
import 'package:project/screens/signUpPage.dart';
import 'package:project/screens/settingsPage.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          backgroundColor: primary_color,
        ),
      ),
      initialRoute: 'signUpPage',
      routes: {
        'homePage': (context) => const HomePage(),
        'chatPage': (context) => const ChatPage(),
        'loginPage': (context) => const LoginPage(),
        'signUpPage': (context) => const SignUpPage(),
        'gratefulnessPage': (context) => const GratefulnessPage(),
        'settingPage': (context) => const SettingsPage(),
        'chatnavscreen': (context) => const ChatNavScreen(),
      },
    );
  }
}
