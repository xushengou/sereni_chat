import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/databases/database_handler.dart';
import 'package:project/misc.dart';
import '../models/message_model.dart';
import '../widgets/chattxt_widget.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String cid;
  final String title;

  const ChatPage({super.key, required this.cid, required this.title});

  @override
  State<ChatPage> createState() => _EditChatPageState();
}

class _EditChatPageState extends State<ChatPage> {
  String? answer;

  final TextEditingController _bodyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<dynamic> getMessageHistory() async {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection('Chat Rooms').doc(widget.cid);
    return docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>; // Gives you the document as a Map
        final List<dynamic> messagesData = data['messages'];

        List<MessageModel> messages = messagesData.map((message) {
          return MessageModel(
            message: message['message'] ?? '',
            user: message['user'] ?? "",
            timestamp: DateTime.fromMillisecondsSinceEpoch(message["timestamp"]) ?? DateTime.now(),
          );
        }).toList();

        Map<String, String> chatHistory = {};
        for (int i = 0; i < messages.length; i++) {
          MessageModel message = messages.elementAt(i);
          String userType = message.user == "AI"? "ChatGPT": "User";
          chatHistory["${i}_$userType"] = message.message;
        }

        return chatHistory;
      },
      onError: (e) {
        print("Error getting document: $e");
        return null;
      },
    );
  }

  Future<void> addNewMessages(String userMessage, String aiMessage, DateTime userTime, DateTime aiTime) async {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection('Chat Rooms').doc(widget.cid);
    return docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>; // Gives you the document as a Map
      final List<dynamic> messagesData = data['messages'];

      messagesData.add({
        "message": userMessage,
        "timestamp": userTime.millisecondsSinceEpoch,
        "user": getUID()
      });

      messagesData.add({
        "message": aiMessage,
        "timestamp": aiTime.millisecondsSinceEpoch,
        "user": "AI"
      });

      docRef.update({
        "messages": messagesData
      });
    },
      onError: (e) {
        print("Error getting document: $e");
      },
    );
  }

  /// Sends a POST request to the server.
  Future<void> sendPostRequest() async {
    // 1. Starts when the user writes a message and taps on the send button
    // See send button.

    // 2. Get the chat history between the user and ChatGPT so far based on
    // what is in the database
    Map<String, String>? messageHistory = await getMessageHistory();
    if (messageHistory == null) {
      return;
    }

    // 3. Take the user's new message (which has not been saved yet), and add it
    // to the chat history Map made in step 2.
    messageHistory["${messageHistory.length}_User"] = _bodyController.text;
    DateTime userTime = DateTime.now();

    //4. Send the chat history Map in the JSON payload
    var payload = {
      "HISTORY": messageHistory,
    };
    var body = json.encode(payload);

    //5. Send POST request and wait for response
    try {
      var response = await http.post(
        Uri.parse('https://sereni-server.onrender.com/get_advice/'),
        headers: {
          'Content-Type': 'application/json',
          // Add any additional headers if needed
        },
        body: body,
      );
      if (response.statusCode == 200) {
        //6. Decode the returned JSON from the server to get ChatGPT's response
        messageHistory["${messageHistory.length}_ChatGPT"] = response.body;
        DateTime aiTime = DateTime.now();

        //7. Update the database with 2 new messages: user's and ChatGPT's
        addNewMessages(_bodyController.text, response.body, userTime, aiTime);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>?> loadChat() async {
    final db = FirebaseFirestore.instance;
    return (await db.collection("Chat Rooms").doc(widget.cid).get()).data();
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
            title: Text(
              widget.title,
              style: const TextStyle(
                color: white,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                child: FutureBuilder(
                    future: loadChat(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic>? chatData = snapshot.data;
                        if (chatData != null) { // Successfully loaded data
                          List<dynamic> messages = chatData["messages"];

                          return ListView.builder(
                            controller: _scrollController,
                            reverse: false,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            itemCount: messages != null ? messages.length : 0,
                            itemBuilder: (context, index) {
                              if (messages == null || messages.isEmpty) {
                                return Container();
                              }
                              return MessageBubble(
                                message: messages[index]["message"],
                                isMe:
                                messages[index]["user"] == DatabaseHandler.getUid()
                                    ? true
                                    : false,
                                timestamp: DateTime.fromMillisecondsSinceEpoch(messages[index]["timestamp"]),
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
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // TextBox
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: ChatTXTWidget(
                            maxLines: 6,
                            fontSize: 10,
                            controller: _bodyController,
                            hintText: 'Let it go!',
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: sendPostRequest,
                          child: const Icon(Icons.arrow_upward),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime timestamp;

  const MessageBubble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    // bool date = false;
    // String currentDate =
    // if()

    return Column(
      children: [

        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Card(
            elevation: 8,
            color: isMe ? lightShadedBlue : white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? white : black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DateBubble extends StatelessWidget {
  final DateTime timestamp;

  const DateBubble(
      {super.key,
        required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15,),
        Center(
          child: Card(
            color: grey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(timestamp),
                style: const TextStyle(
                  color: black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
