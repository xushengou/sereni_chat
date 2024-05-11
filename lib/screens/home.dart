import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/screens/chat_navigation.dart';
import 'package:project/screens/gratefulness.dart';
import 'package:project/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayName = '';
  List<String> dailyOptions = <String>["Awesome!", "It's Okay~", "Horriable!"];
  var _dailyValue;
  List<String> tips = <String>[
    "Interact with friends",
    "Share out your trouble",
    "",
  ];

  @override
  void initState() {
    super.initState();
    // Retrieve current user's display name when the widget is initialized
    getUserDisplayName();
  }

  Future<void> getUserDisplayName() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    // Retrieve user's display name
    if (user != null) {
      setState(() {
        _displayName = user.displayName ?? 'No name';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _displayName.length > 15
                    ? '${_displayName.substring(0, 15)}...'
                    : _displayName,
                style: const TextStyle(
                  color: white,
                  fontSize: 30.0,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 20.0,
              //   ),
              //   child: IconButton.outlined(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const SettingsPage()));
              //     },
              //     icon: const Icon(
              //       Icons.person,
              //     ),
              //     iconSize: 40.0,
              //     style: ButtonStyle(
              //       side: MaterialStateProperty.all(
              //         const BorderSide(
              //             color: black, width: 2.0, style: BorderStyle.solid),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        // actions: [
        //
        // ],
        backgroundColor: darkTheme1,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "How's your day?",
                      style: TextStyle(
                        fontSize: 25,
                        color: white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    dailyOptions[0],
                    style: const TextStyle(color: white),
                  ),
                  leading: Radio<String>(
                    value: dailyOptions[0],
                    groupValue: _dailyValue,
                    onChanged: (String? value) {
                      setState(() {
                        _dailyValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    dailyOptions[1],
                    style: const TextStyle(color: white),
                  ),
                  leading: Radio<String>(
                    value: dailyOptions[1],
                    groupValue: _dailyValue,
                    onChanged: (String? value) {
                      setState(() {
                        _dailyValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    dailyOptions[2],
                    style: const TextStyle(color: white),
                  ),
                  leading: Radio<String>(
                    value: dailyOptions[2],
                    groupValue: _dailyValue,
                    onChanged: (String? value) {
                      setState(() {
                        _dailyValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
                width: double.maxFinite,
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: darkShadedWhite),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GratefulnessPage()));
                    },
                    child: const Text(
                      'Complete your gratefulness',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  const Text(
                    "Feeling tired? Unhappy? Feeling that no one understands you?",
                    style: TextStyle(
                      fontSize: 20,
                      color: white,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tips:",
                            style: TextStyle(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: tips.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 50,
                              child: Text(
                                '${index + 1}) ${tips[index]}',
                                style: const TextStyle(
                                  color: white,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
