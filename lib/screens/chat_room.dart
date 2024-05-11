import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/color_const.dart';
import 'package:project/databases/database_handler.dart';
import '../models/message_model.dart';
import '../widgets/chattxt_widget.dart';
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

  /// Sends a POST request to the server.
  Future<void> sendPostRequest() async {
    var url = Uri.parse('https://sereni-server.onrender.com/get_advice');

    //1. Starts when the user writes a message and taps on the send button
    //2. Get the chat history between the user and ChatGPT so far based on
    // what is in the database
    //3. Take the user's new message (which has not been saved yet), and add it
    // to the chat history Map made in step 2.
    //4. Send the chat history Map in the JSON payload
    //5. Send POST request and wait for response
    //6. Decode the returned JSON from the server to get ChatGPT's response
    //7. Update the database with 2 new messages: user's and ChatGPT's

    Map<String, String> chat_history = {};

    // Create the payload.
    /*
    Map<String, String>
    {
      "User": "MESSAGE_1",
      "ChatGPT": "MESSAGE_2",
    }
    */

    var payload = {
      "HISTORY": currentFormResponse["GOAL"].toString(),
    };
    var body = json.encode(payload);

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any additional headers if needed
        },
        body: body,
      );
      if (response.statusCode == 200) {
        // Decode the response. This is a dictionary of String to dynamics
        var jsonResponse = json.decode(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
                  child: StreamBuilder<List<MessageModel>>(
                    // inside the <> you enter the type of your stream
                    stream: DatabaseHandler.getMessages(widget.cid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var messages = snapshot.data;
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
                            message: messages[index].message,
                            isMe:
                                messages[index].user == DatabaseHandler.getUid()
                                    ? true
                                    : false,
                            timestamp: messages[index].timestamp,
                          );
                        },
                      );
                    },
                  ),
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
                              final message = {
                                'message': _bodyController.text,
                                'user': DatabaseHandler.getUid(),
                                'timestamp': DateTime.now(),
                              };
                              _bodyController.clear();

                              final messageAI = {
                                'message': answer,
                                'user': 'AI',
                                'timestamp': DateTime.now(),
                              };

                              setState(() => _firestore
                                      .collection('Chat Rooms')
                                      .doc(widget.cid)
                                      .update({
                                    "messages": FieldValue.arrayUnion(
                                        [message, messageAI])
                                  }));
                            }
                          },
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
