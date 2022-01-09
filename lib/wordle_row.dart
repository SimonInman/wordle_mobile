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
      boxes.add(Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2.0)),
        child: const Text(
          "A",
          style: TextStyle(fontSize: 22.0, color: Colors.black, shadows: null),
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
