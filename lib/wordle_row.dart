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

  Color getBgColor(int i) {
    if (answer.length <= i) return Colors.white;
    if (correct[i] == answer[i]) return Colors.green;
    if (correct.contains(answer[i])) return Colors.orangeAccent;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> boxes = [];
    for (int i = 0; i < wordLength; i++) {
      String text = (answer.length > i) ? answer[i] : "  ";

      boxes.add(Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            color: getBgColor(i)),
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
