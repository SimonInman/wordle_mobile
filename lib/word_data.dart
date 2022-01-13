
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordData extends StateNotifier<List<String>> {
  Random prng = Random();
  String correctWord = "";

  WordData(List<String>? state) : super(state ?? []);


  Future<void> loadWords(int wordLength, BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/$wordLength-letter-words.json");
    List<String> wordList = (jsonDecode(data) as List<dynamic>).cast<String>();
    state = wordList;
    nextWord();
  }

  void nextWord() {
    correctWord = state[prng.nextInt(state.length)];
  }
}