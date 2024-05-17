import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/misc.dart';
import 'package:project/screens/login.dart';
import '../../color_const.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({super.key});

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  void onPressLogout() {
    displayAlertForm(
      context,
      const Column(
        children: [
          Text("Are you sure you want to log out?")
        ],
      ),
      Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
              navigateTo(context, LoginPage());
            },
            child: Text("Yeah")
          )
        ],
      )
    );
  }

  void onPressDelete() {
    displayAlertForm(
      context,
      Column(
        children: [
          Text("Are you sure you want to delete your account?")
        ],
      ),
      Row(
        children: [
          ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.currentUser?.delete();
                navigateTo(context, LoginPage());
              },
              child: Text("Yeah")
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkTheme1,
        title: const Text(
          "Account Management",
          style: TextStyle(
            color: white,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: onPressLogout,
              child: Text("Log Out")
            ),
            ElevatedButton(
              onPressed: () {

              },
              child: Text("Delete Account")
            ),
          ],
        ),
      ),
    );
  }
}
