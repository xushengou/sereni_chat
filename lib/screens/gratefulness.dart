import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:project/color_const.dart';
import 'package:project/widgets/list_box_widget.dart';
// import 'package:intl/intl.dart';

class GratefulnessPage extends StatefulWidget {
  const GratefulnessPage({super.key});

  @override
  State<GratefulnessPage> createState() => _GratefulnessPageState();
}

class _GratefulnessPageState extends State<GratefulnessPage> {
  var gratefulnessList = [];
  // current date in mm/dd/yyyy
  // DateTime now = DateTime.now();
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

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
        body: Expanded(
          child: Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: gratefulnessList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListBoxWidget(
                    title: '${index + 1}. ${gratefulnessList[index]}',
                    date: "03/19/2024",
                    username: "username",
                    marginVal: 5.0);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Add a new gratefulness',
                style: TextStyle(
                  color: white,
                ),
              ),
              content: TextField(
                onSubmitted: (value) {
                  if (value != "") {
                    gratefulnessList.add(value);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
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
            ),
          ),
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
