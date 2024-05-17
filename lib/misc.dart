import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

/// A helper function to reduce boilerplate code for switching to another screen.
void navigateTo(BuildContext context, Widget newScreen) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => newScreen,
    ),
  );
}

/// Displays the a generic alert dialog.
void displayAlertForm(BuildContext context, Widget body, Row exitButtons) {
  showDialog(
    context: context,
    builder: (context) => FluidDialog(
      // Set the first page of the dialog.
      rootPage: FluidDialogPage(
        alignment: Alignment.center, //Aligns the dialog to the bottom left.
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                body,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    exitButtons,
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent
                        ),
                        child: Text("Nevermind")
                    ),
                  ],
                ),
              ],
            ),
          ),
        ), // This can be any widget.
      ),
    ),
  );
}

/// Gets the UID of the currently logged in user.
String getUID() {
  return FirebaseAuth.instance.currentUser!.uid;
}