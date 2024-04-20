import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project/color_const.dart';
import 'package:project/databases/database_handler.dart';
import '../models/message_model.dart';
import '../widgets/chattxt_widget.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String cid;

  const ChatPage({super.key, required this.cid});

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
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                    // inside the <> you enter the type of your stream
                    stream: DatabaseHandler.getMessages(widget.cid),
                    builder: (context, snapshot) {
                      print(snapshot);
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
                          if(messages == null || messages.isEmpty){
                            return Container();
                          }
                          return MessageBubble(
                            message: messages[index].message,
                            isMe: messages[index].user == DatabaseHandler.getUid() ? true : false,
                            timestamp: messages[index].timestamp,
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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

// finish this
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
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
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
  }
}
