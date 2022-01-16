import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/data/wordlist_repo.dart';
import 'package:wordle_mobile/providers/settings_provider.dart';

enum GameStatus { loading, started, win, lose }

class WrongWordLengthException implements Exception {
  int correctLength;

  WrongWordLengthException(this.correctLength);

  @override
  String toString() {
    return "Answer submitted is of wrong length. Submit a word of $correctLength characters";
  }
}

class GameState {
  final GameSettings settings;
  final GameStatus gameStatus;
  final String correctWord;
  late final List<String> attempts;

  GameState(this.settings,
      {this.correctWord = "begin",
      this.gameStatus = GameStatus.loading,
      List<String>? attempts}) {
    this.attempts = attempts ?? List.empty();
  }
}

class GameStateNotifier extends StateNotifier<GameState> {
  Random rng = Random();

  GameStateNotifier(GameSettings settings) : super(GameState(settings));

  Future<void> resetWord() async {
    final words = await loadWords(state.settings.wordSize);
    state = GameState(state.settings,
        attempts: List.empty(),
        correctWord: words[rng.nextInt(words.length)],
        gameStatus: GameStatus.started);
  }

  void attemptAnswer(String answer) {
    if (kDebugMode) {
      print("attemptAnswer : $answer");
    }
    if (answer.length != state.correctWord.length) {
      throw WrongWordLengthException(state.correctWord.length);
    }
    state = GameState(state.settings,
        gameStatus: state.gameStatus,
        correctWord: state.correctWord,
        attempts: [...state.attempts, answer]);
  }
}

final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  final gameSettings = ref.watch(gameSettingsProvider);
  final notifier = GameStateNotifier(gameSettings);
  notifier.resetWord();
  return notifier;
});
