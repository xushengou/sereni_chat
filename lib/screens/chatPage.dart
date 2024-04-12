import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/color_const.dart';
import '../widgets/chattxt_widget.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _EditChatPageState();
}

class _EditChatPageState extends State<ChatPage> {
  TextEditingController _bodyController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primary_color,
          // backgroundColor: Colors.white,
          title: const Text(
            "Anonymous/AI",
            style: TextStyle(
              color: secondary_color,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                stream: _firestore.collection("Chat Rooms").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var messages = snapshot.data!.docs;
                  List<MessageBubble> messageWidgets = [];
                  for (var message in messages) {
                    var messageText = message['mesage'];
                    var isMe = message['isMe'];
                    var timeStamp = message['timestamp'];
                    var messageWidget = MessageBubble(
                      messageText,
                      isMe,
                      timeStamp,
                    );
                    messageWidgets.add(messageWidget);
                  }

                  return ListView(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    children: messageWidgets,
                  );
                },
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Expanded(
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
                        onPressed: () {
                          final message = {
                            'message': _bodyController.text,
                            'isMe': true,
                            'timestamp': DateTime.now(),
                          };
                          setState(() => _firestore.collection('Chat data').doc().collection("messages").add(message));
                          _bodyController.clear();
                        },
                        child: const Icon(Icons.arrow_upward),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            )
          ],
        ),
      ),
    );
  }
}

// finish this
class MessageBubble extends StatelessWidget{
  final String message;
  final bool isMe;
  final DateTime timestamp;

  const MessageBubble(this.message, this.isMe, this.timestamp, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100.0,
          child: Center(
            child: Card(
              color: shaded_blue,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  DateFormat.yMMMd().format(timestamp),
                  style: const TextStyle(
                    color: secondary_color,
                  ),
                ),
              ),
            ),
          ),
        ),

        Align(
          alignment: isMe
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(message),
            ),
          ),
        ),
      ],
    );
  }}
