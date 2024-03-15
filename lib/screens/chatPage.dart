import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/color_const.dart';
import '../widgets/chattxt_widget.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _EditChatPageState();
}

class _EditChatPageState extends State<ChatPage> {
  TextEditingController _bodyController = TextEditingController();

  List<Message> messages = [
    Message(
      text: "Hello there!",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: "Hello World!",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentByMe: false,
    ),
  ];

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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GroupedListView<Message, DateTime>(
                padding: const EdgeInsets.all(8),
                reverse: true, // Important
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                elements: messages,
                groupBy: (message) => DateTime(
                  message.date.year,
                  message.date.month,
                  message.date.day,
                ),
                groupHeaderBuilder: (Message message) => SizedBox(
                  height: 100.0,
                  child: Center(
                    child: Card(
                      color: shaded_blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          DateFormat.yMMMd().format(message.date),
                          style: const TextStyle(
                            color: secondary_color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context, Message message) => Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(message.text),
                    ),
                  ),
                ),
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
                          final message = Message(
                            text: _bodyController.text,
                            date: DateTime.now(),
                            isSentByMe: true,
                          );
                          setState(() => messages.add(message));
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

class Message {
  late String text;
  late DateTime date;
  late bool isSentByMe;

  Message({required this.text, required this.date, required this.isSentByMe});
}
