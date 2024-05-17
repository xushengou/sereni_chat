import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:project/widgets/list_box_widget.dart';

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
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "My Gratefulness",
            style: Theme.of(context).textTheme.headlineSmall,
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
                  marginVal: 5.0,
                  maxLength: 100,
                );
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
              title: Text(
                'Add a new gratefulness',
                style: Theme.of(context).textTheme.titleMedium,
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
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  focusColor: Colors.black,
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
