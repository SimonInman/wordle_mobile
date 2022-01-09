import 'package:flutter/material.dart';
import 'package:wordle_mobile/wordle_row.dart';

class WordlePage extends StatefulWidget {
  const WordlePage({Key? key}) : super(key: key);

  @override
  _WordlePageState createState() => _WordlePageState();
}

class _WordlePageState extends State<WordlePage> {
  int _wordSize = 5;
  int _attempts = 6;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < _attempts; i++) {
      rows.add(
          WordleRow(wordLength: _wordSize, answer: "abcde", correct: "abcde"));
    }

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ),
      ),
    );
  }
}
