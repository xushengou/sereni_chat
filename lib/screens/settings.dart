import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/misc.dart';
import 'package:project/screens/settings_screens/account_management.dart';
import 'package:project/screens/settings_screens/appearance.dart';

import '../color_const.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Widget addSection(String name, Column body) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: const TextStyle(
              color: lightShadedWhite,
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: lightShadedWhite),
          ),
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: body
          ),
        )
      ],
    );
  }

  Widget addDivider() {
    return const Divider(
      color: lightShadedWhite,
    );
  }

  Widget makeSettingsLink(IconData icon, String name, Widget? destination) {
    return GestureDetector(
      onTap: (){
        if (destination != null) {
          navigateTo(context, destination);
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: lightShadedWhite,
            size: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              name,
              style: const TextStyle(
                color: lightShadedWhite,
                fontSize: 20.0,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              color: lightShadedWhite,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkTheme1,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: white,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              addSection(
                "Account Settings",
                Column(
                  children: [
                    makeSettingsLink(Icons.person, "Account", const AccountManagement()),
                    // addDivider(),
                    // makeSettingsLink(Icons.privacy_tip_outlined, "Privacy & Safety", null)
                  ],
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              addSection(
                "App Settings",
                Column(
                  children: [
                    makeSettingsLink(Icons.palette, "Appearance", const Appearance()),
                    // addDivider(),
                    // makeSettingsLink(Icons.accessibility_new, "Accessibility", null),
                    // addDivider(),
                    // makeSettingsLink(Icons.translate_outlined, "Language", null),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
