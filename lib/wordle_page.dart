import 'package:flutter/material.dart';
import 'package:wordle_mobile/wordle_row.dart';

class WordlePage extends StatefulWidget {
  WordlePage({Key? key}) : super(key: key);

  TextEditingController answerController =
      TextEditingController.fromValue(TextEditingValue.empty);

  @override
  _WordlePageState createState() => _WordlePageState();
}

class _WordlePageState extends State<WordlePage> {
  int _wordSize = 5;
  int _attempts = 6;
  int _nextAttempt = 0;
  List<String> _attemptedAnswers = List.filled(6, "");

  void updateWordSize(int newSize) {
    setState(() {
      _wordSize = newSize;
    });
  }

  void updateAttempts(int newAttempts) {
    setState(() {
      _attempts = newAttempts;
      _attemptedAnswers = List.filled(newAttempts, "");
    });
  }

  void attempt() {
    setState(() {
      _attemptedAnswers[_nextAttempt] = widget.answerController.value.text;
      _nextAttempt++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < _attempts; i++) {
      rows.add(WordleRow(
          wordLength: _wordSize,
          answer: _attemptedAnswers[i],
          correct: "abcde"));
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: widget.answerController,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) => attempt(),
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                hintText: "answer",
              ),
            ),
          ),
          Column(
            children: rows,
          )
        ],
      ),
    );
  }
}
