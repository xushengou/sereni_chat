import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project/color_const.dart';
import 'package:project/databases/database_handler.dart';
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
  late final OpenAI _openAI;
  bool _isLoading = true;
  String? answer;

  final TextEditingController _bodyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // Initialize ChatGPT SDK
    _openAI = OpenAI.instance.build(
      token: dotenv.env['OPENAI_API_KEY'],
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    _handleInitialMessage();
    super.initState();
  }

  Future<void> _handleInitialMessage() async {
    String userPrompt = _bodyController.text;

    final request = ChatCompleteText(
      messages: [
        Messages(
          role: Role.user,
          content: userPrompt,
        ),
      ],
      maxToken: 500,
      model: GptTurbo0631Model(),
    );

    ChatCTResponse? response = await _openAI.onChatCompletion(request: request);

    setState(() {
      answer = response!.choices.first.message!.content.trim();
      _isLoading = false;
    });
  }

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
            title: Text(
              widget.title,
              style: const TextStyle(
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
                              await _handleInitialMessage();
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
    return Column(
      children: [

        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Card(
            elevation: 8,
            color: isMe ? shaded_blue : secondary_color,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
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
