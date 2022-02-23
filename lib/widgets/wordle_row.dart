import 'package:flutter/material.dart';
      import 'dart:math';

class WordleRow extends StatelessWidget {
  final bool attempted;
  final int wordLength;
  final String answer;
  final String correct;
  late int indexToMessWith;

  WordleRow(
      {Key? key,
      required this.attempted,
      required this.wordLength,
      required this.answer,
      required this.correct,
      }):  super(key: key) {
        // assert(answer.isEmpty || answer.length == correct.length, 'Incorrect length guess made');

    final int randomSeed =  answer.codeUnits.fold(0, (sum, val) => sum+val);
    final Random random = Random(randomSeed);
    indexToMessWith = random.nextInt(5);
    }

  Color getBgColor(int i) {
    final realColour = _getBgColor(i);

    if (answer == correct) return realColour;
    if (!attempted) return realColour;
    if (i != indexToMessWith) return realColour;

    if (realColour == Colors.green) {
      return Colors.orangeAccent;
    } else {
      return Colors.green;
    }
  }

  Color _getBgColor(int i) {
    if (!attempted) return Colors.white;
    if (correct[i] == answer[i]) return Colors.green;
    if (correct.contains(answer[i])) return Colors.orangeAccent;
    return Colors.grey;
  }

  BoxBorder? getBorder() {
    if (!attempted) return Border.all(color: Colors.grey, width: 2.0);
    return Border.all(color: Colors.transparent, width: 2.0);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> boxes = [];
    for (int i = 0; i < wordLength; i++) {
      String text = (answer.length > i) ? answer[i] : "  ";

      boxes.add(_box(text, i));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: boxes,
    );
  }

  Container _box(String text, int letterIndex) {
      var boxDecoration = BoxDecoration(
            border: getBorder(),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            color: getBgColor(letterIndex));

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(2),
      decoration: boxDecoration,
      child: SizedBox(
        width: 18,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            color: attempted ? Colors.white : Colors.grey,
            shadows: null,
          ),
        ),
      ),
    );
  }
}
