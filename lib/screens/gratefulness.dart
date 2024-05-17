import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/color_const.dart';

import '../misc.dart';

class GratefulnessPage extends StatefulWidget {
  const GratefulnessPage({super.key});

  @override
  State<GratefulnessPage> createState() => _GratefulnessPageState();
}

class _GratefulnessPageState extends State<GratefulnessPage> {
  var gratefulnessList = [];

  Future<void> onSubmitGratefulness(String content) async {
    final db = FirebaseFirestore.instance;

    final document = <String, dynamic>{
      "user": getUID(),
      "content": content,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };

    db.collection("Posts").add(document);
  }

  void onPressAddGratefulnessButton() {
    String response = "";

    displayAlertForm(
        context,
        Column(
          children: [
            const Text("What are you grateful for today?"),
            TextField(
              onChanged: (value) {
                response = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: lightShadedBlue,
                filled: true,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  if (response != "") {
                    setState(() {
                      gratefulnessList.add(response);
                    });
                    onSubmitGratefulness(response);
                    Navigator.pop(context);
                  }
                },
                child: Text("Submit")
            )
          ],
        )
    );
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> _loadPostsForUser(String userId) async {
    final db = FirebaseFirestore.instance;
    final userRef = db.collection("User Data").doc(userId);
    return (await db.collection("Posts").where("user", isEqualTo: getUID()).get()).docs;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white),
          backgroundColor: darkTheme1,
          title: const Text(
            "My Gratefulness",
            style: TextStyle(color: white),
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: _loadPostsForUser(getUID()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) { // Successfully loaded data
                List<QueryDocumentSnapshot<Map<String, dynamic>>>? posts = snapshot.data;
                if (posts != null) {
                    return ListView.builder( // Once posts are retrieved, generates ListView
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> document = posts[index].data();

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat("MM-dd-yyyy").format(DateTime.fromMillisecondsSinceEpoch(document["timestamp"]))),
                                Text(document["content"]),
                              ],
                            ),
                          ),
                        );
                      },
                  );
                } else { // Problem loading data
                  return const Text("Error loading data");
                }
              } else { // Loading data
                return const Text("loading...");
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onPressAddGratefulnessButton();
          },
          backgroundColor: white,
          child: const Icon(
            Icons.add,
            color: darkTheme1,
          ),
        ),
      ),
    );
  }
}
