import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/gratefulness.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayName = '';
  List<String> quotes = <String>[
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "The only way to do great work is to love what you do. - Steve Jobs",
    "Every moment is a fresh beginning. - T.S. Eliot",
    "You are never too old to set another goal or to dream a new dream. - C.S. Lewis",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
    "The only limit to our realization of tomorrow will be our doubts of today. - Franklin D. Roosevelt",
    "The only person you are destined to become is the person you decide to be. - Ralph Waldo Emerson",
    "In the middle of difficulty lies opportunity. - Albert Einstein",
    "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
    "You must be the change you wish to see in the world. - Mahatma Gandhi",
    "The way to get started is to quit talking and begin doing. - Walt Disney",
    "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. - Albert Schweitzer",
    "You don't have to be great to start, but you have to start to be great. - Zig Ziglar",
    "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "It does not matter how slowly you go as long as you do not stop. - Confucius",
    "The only limit to our realization of tomorrow is our doubts of today. - Franklin D. Roosevelt",
    "The greatest glory in living lies not in never falling, but in rising every time we fall. - Nelson Mandela",
    "The only way to achieve the impossible is to believe it is possible. - Charles Kingsleigh",
    "It always seems impossible until it's done. - Nelson Mandela",
    "Opportunities don't happen, you create them. - Chris Grosser",
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle. - Christian D. Larson",
    "The only thing that stands between you and your dream is the will to try and the belief that it is actually possible. - Joel Brown",
    "You are never too old to set another goal or to dream a new dream. - C.S. Lewis",
    "With the new day comes new strength and new thoughts. - Eleanor Roosevelt",
    "The only person you are destined to become is the person you decide to be. - Ralph Waldo Emerson",
    "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
    "In the middle of difficulty lies opportunity. - Albert Einstein",
    "You must be the change you wish to see in the world. - Mahatma Gandhi",
    "The only way to do great work is to love what you do. - Steve Jobs",
    "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. - Albert Schweitzer",
    "The only way to do great work is to love what you do. - Steve Jobs",
    "You don't have to be great to start, but you have to start to be great. - Zig Ziglar",
    "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "It does not matter how slowly you go as long as you do not stop. - Confucius",
    "The only limit to our realization of tomorrow is our doubts of today. - Franklin D. Roosevelt",
    "The greatest glory in living lies not in never falling, but in rising every time we fall. - Nelson Mandela",
    "The only way to achieve the impossible is to believe it is possible. - Charles Kingsleigh",
    "It always seems impossible until it's done. - Nelson Mandela",
    "Opportunities don't happen, you create them. - Chris Grosser",
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle. - Christian D. Larson",
    "The only thing that stands between you and your dream is the will to try and the belief that it is actually possible. - Joel Brown"
  ];
  List<String> dailyQuotes = <String>[];

  @override
  void initState() {
    getDailyQuote();
    super.initState();
    getUserDisplayName();
  }

  void getDailyQuote() {
    Random random = Random();
    dailyQuotes.add(quotes[random.nextInt(quotes.length)]);
    dailyQuotes.add(quotes[random.nextInt(quotes.length)]);
    dailyQuotes.add(quotes[random.nextInt(quotes.length)]);
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
    double boxDistance = (MediaQuery.of(context).size.width -
            2 * ((MediaQuery.of(context).size.width - 20) / 3)) /
        6;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Home",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // Four box of nav
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateTime.now().hour < 12
                          ? "Good morning, $_displayName"
                          : "Good afternoon, $_displayName",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 20) / 3,
                        height: (MediaQuery.of(context).size.width - 20) / 3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const GratefulnessPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Text(
                              'Goals',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                          width:
                              boxDistance), // calculate the estimated width for the space between all four blocks, could use padding?

                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 20) / 3,
                        height: (MediaQuery.of(context).size.width - 20) / 3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const GratefulnessPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Text(
                              'To-dos',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: boxDistance),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 20) / 3,
                        height: (MediaQuery.of(context).size.width - 20) / 3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const GratefulnessPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Text(
                              'Grateful...',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                          width:
                              boxDistance), // calculate the estimated width for the space between all four blocks, could use padding?

                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 20) / 3,
                        height: (MediaQuery.of(context).size.width - 20) / 3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const GratefulnessPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Text(
                              'Explore',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),

              // to-do list
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Today",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: dailyQuotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50,
                          child: Text(
                            '${index + 1}) ${dailyQuotes[index]}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),

              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Quote of the day!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: dailyQuotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50,
                          child: Text(
                            '${index + 1}) ${dailyQuotes[index]}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class boxWidget extends StatelessWidget {
  final String title;

  const boxWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const GratefulnessPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        padding: const EdgeInsets.all(20.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
