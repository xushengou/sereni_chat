import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/databases/database_handler.dart';
import '../misc.dart';
import '../models/message_model.dart';
import '../widgets/text_box_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

      setState(() {

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

    print("SENDING REQUEST: ${payload}");

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
        print("GOT RESPONSE: ${response.body}");

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
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall,
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
                            hintText: 'Enter Text Here: ',
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (widget.title == 'Person') {
                              final message = {
                                'message': _bodyController.text,
                                'user': DatabaseHandler.getUid(),
                                'timestamp': DateTime.now(),
                              };
                              _bodyController.clear();
                              setState(() => _firestore
                                      .collection('Chat Rooms')
                                      .doc(widget.cid)
                                      .update({
                                    "messages": FieldValue.arrayUnion([message])
                                  }));
                            } else if (widget.title == 'AI') {
                              sendPostRequest();
                            }
                          },
                          child: Icon(
                            Icons.arrow_upward,
                            size: 30.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
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
            color: isMe ? Colors.blue.shade100 : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                message,
                style: TextStyle(
                  color:
                      isMe ? const Color.fromARGB(255, 62, 62, 62) : Colors.black,
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

  const DateBubble({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Center(
          child: Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(timestamp),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
