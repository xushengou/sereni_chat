import 'package:flutter/material.dart';
import 'package:project/color_const.dart';

class ListBoxWidget extends StatelessWidget {
  final String? title;
  final String? date;
  final String? username;
  final double? marginVal;

  // current date in mm/dd/yyyy
  // DateTime now = DateTime.now();
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  const ListBoxWidget({
    super.key,
    this.title,
    this.date,
    this.username,
    this.marginVal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(marginVal as double),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainGrey,
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              //Title
              Text(
                "${title}".length > 15 ? "${title}".substring(0, 15)+'...' : "${title}",
                style: const TextStyle(
                  color: secondary_color,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              Text(
                "${date}",
                style: const TextStyle(
                  color: subTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "By: ${username}",
                style: const TextStyle(
                  color: secondary_color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
