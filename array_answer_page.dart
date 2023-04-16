import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer(
      {super.key,
      required this.answerText,
      required this.answerColor,
      required this.answerTap});

  final String answerText;
  final Color answerColor;
  final void Function() answerTap;

  ////////////////////DESIGN FOR THE ANSWERS. THE BOXES, THE COLOR OF BOXES, THE TEXT INSIDE IT, ETC.///////////////////////////
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: answerColor,
            border: Border.all(color: Color.fromARGB(255, 160, 44, 195)),
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          answerText,
          style: const TextStyle(fontSize: 15.0, color: Colors.black),
        ),
      ),
    );
  }
}
