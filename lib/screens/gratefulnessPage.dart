import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:project/color_const.dart';

import '../widgets/std_text_field.dart';

class GratefulnessPage extends StatefulWidget {
  const GratefulnessPage({super.key});

  @override
  State<GratefulnessPage> createState() => _GratefulnessPageState();
}

class _GratefulnessPageState extends State<GratefulnessPage> {
  var gratefulnessList = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primary_color,
          title: const Text(
            "My Gratefulness",
            style: TextStyle(color: secondary_color),
          ),
        ),
        body: Expanded(
          child: Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: gratefulnessList.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  child: Text(
                    '${index + 1}) ${gratefulnessList[index]}',
                    style: const TextStyle(
                      color: secondary_color,
                      fontSize: 20.0,
                    ),
                  ),
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
              title: const Text(
                'Add a new gratefulness',
                style: TextStyle(
                  color: secondary_color,
                ),
              ),
              content: TextField(
                onSubmitted: (value) {
                  if(value != ""){
                    gratefulnessList.add(value);
                    Navigator.pop(context);
                  }
                  else{
                    Navigator.pop(context);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.blue.shade100, //
                  filled: true,
                ),
              ),
              // actions: <Widget>[
              //   TextButton(
              //     onPressed: () => Navigator.pop(context, 'Cancel'),
              //     child: const Text('Cancel'),
              //   ),
              //   TextButton(
              //     onPressed: () {
              //       gratefulnessList.add(newGratefulnessItem);
              //       Navigator.pop(context, 'Add');
              //     },
              //     child: const Text('Add'),
              //   ),
              // ],
            ),
          ),
          backgroundColor: secondary_color,
          child: const Icon(
            Icons.add,
            color: primary_color,
          ),
        ),
      ),
    );
  }
}
