import 'dart:convert';

import 'package:flutter/services.dart';

const loadShuffledWords = true;

Future<List<String>> loadWords(int wordLength) async {

String data;
if (loadShuffledWords) {
  data = await rootBundle.loadString("assets/$wordLength-letter-words.json");

} else {

  data = await rootBundle.loadString("assets/shuffled-$wordLength-letter-words.json");
}

  List<String> wordList = (jsonDecode(data) as List<dynamic>)
      .cast<String>()
      .map((e) => e.toUpperCase())
      .toList();
  return wordList;
}

