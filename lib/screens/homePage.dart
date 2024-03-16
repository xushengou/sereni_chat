import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/screens/chatNavScreen.dart';
import 'package:project/screens/gratefulnessPage.dart';
import 'package:project/screens/settingsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userName = "Carson Ou";
  List<String> dailyOptions = <String>["Awesome!", "It's Okay~", "Horriable!"];
  var _dailyValue;
  List<String> tips = <String>[
    "Interact with friends",
    "Share out your trouble",
    "",
  ];

  void onTabTapped(int index) {
    if(index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    else if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatNavScreen()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
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
                userName,
                style: const TextStyle(
                  color: secondary_color,
                  fontSize: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: IconButton.outlined(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                  },
                  icon: const Icon(
                    Icons.person,
                  ),
                  iconSize: 40.0,
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // actions: [
        //
        // ],
        backgroundColor: primary_color,
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
                        color: secondary_color,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    dailyOptions[0],
                    style: const TextStyle(color: secondary_color),
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
                    style: const TextStyle(color: secondary_color),
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
                    style: const TextStyle(color: secondary_color),
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
                  decoration: const BoxDecoration(color: mainGrey),
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
                        color: secondary_color,
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
                      color: secondary_color,
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
                              color: secondary_color,
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
                                  color: secondary_color,
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
