// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// class TipsPage extends StatefulWidget {
//   const TipsPage({
//     Key? key,
//     required this.sports,
//     required this.gender,
//     required this.age,
//     required this.info,
//   }) : super(key: key);
//
//   final List<String> sports;
//   final String gender;
//   final int age;
//   final String info;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _TipsPageState();
//   }
// }
//
// class _TipsPageState extends State<TipsPage> {
//   late final OpenAI _openAI;
//   bool _isLoading = true;
//   String? tips;
//
//   @override
//   void initState() {
//     // Initialize ChatGPT SDK
//     _openAI = OpenAI.instance.build(
//       token: dotenv.env['OPENAI_API_KEY'],
//       baseOption: HttpSetup(
//         receiveTimeout: const Duration(seconds: 30),
//       ),
//     );
//     _handleInitialMessage();
//     super.initState();
//   }
//
//   Future<void> _handleInitialMessage() async {
//     String userPrompt = "Could you give me some sport tips of these sports: "
//         "${widget.sports} and this is my personal information: "
//         "${widget.gender}, ${widget.age} years, "
//         "${widget.info}. Please give me only the tips. Do not"
//         " write anything before the tips";
//
//     final request = ChatCompleteText(
//       messages: [
//         Messages(
//           role: Role.user,
//           content: userPrompt,
//         ),
//       ],
//       maxToken: 1500, // max response length
//       model: GptTurbo0631Model(),
//     );
//
//     ChatCTResponse? response = await _openAI.onChatCompletion(request: request);
//
//     setState(() {
//       tips = response!.choices.first.message!.content.trim();
//       _isLoading = false;
//     });
//   }
// }
