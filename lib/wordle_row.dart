import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordleRow extends StatelessWidget {
  final int wordLength;
  final String answer;
  final String correct;

  const WordleRow(
      {Key? key,
      required this.wordLength,
      required this.answer,
      required this.correct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> boxes = [];
    for (int i = 0; i < wordLength; i++) {
      String text = (answer.length > i) ? answer[i] : "  ";
      Color bgColor =
          (answer.length > i) ? Colors.grey : Colors.white;
      boxes.add(Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            color: bgColor),
        child: SizedBox(
          width: 18,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              shadows: null,
            ),
          ),
        ),
      ));
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: boxes,
      ),
    );
  }
}
