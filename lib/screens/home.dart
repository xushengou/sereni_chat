import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/screens/gratefulness.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayName = '';
  List<String> dailyOptions = [
    "Awesome!",
    "It's Okay.",
    "Horrible!",
  ];
  String _dailyValue = '';

  List<String> tips = <String>[
    "Interact with friends",
    "Talk about your feelings with others",
    "Get some fresh air",
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

  Widget currentStatus() {
    List<Widget> choices = [];
    for (int i = 0; i < dailyOptions.length; i++) {
      choices.add(
        ListTile(
          title: Text(
            dailyOptions[i],
            style: const TextStyle(color: white),
          ),
          leading: Radio<String>(
            value: dailyOptions[i],
            groupValue: _dailyValue,
            onChanged: (String? value) {
              setState(() {
                _dailyValue = value!;
              });
            },
          ),
        )
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "How's your day going?",
            style: TextStyle(
              fontSize: 25,
              color: white,
            ),
          ),
        ),
        Column(
          children: choices,
        )
      ],
    );
  }

  Widget tipsAndAdvice() {
    return Padding(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tips:",
                style: TextStyle(
                  fontSize: 16,
                  color: white,
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
        ],
      ),
    );
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
            ],
          ),
        ),
        backgroundColor: darkTheme1,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            currentStatus(),
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
            tipsAndAdvice()
          ],
        ),
      ),
    );
  }
}
