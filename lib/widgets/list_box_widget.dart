import 'package:flutter/material.dart';

class ListBoxWidget extends StatelessWidget {
  final String? title;
  final String? date;
  final String? username;
  final double? marginVal;
  final int maxLength;

  // current date in mm/dd/yyyy
  // DateTime now = DateTime.now();
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  const ListBoxWidget({
    super.key,
    this.title,
    this.date,
    this.username,
    this.marginVal,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(marginVal as double),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              //Title
              Text(
                "${title}".length > maxLength ? "${title}".substring(0, maxLength)+'...' : "${title}",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(
                width: 20,
              ),

              Text(
                "${date}",
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ],
      ),
    );
  }
}
