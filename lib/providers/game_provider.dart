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
  late final List<String> words;
  late final List<String> attempts;
  int attemptedUpto;

  GameState(this.settings,
      {this.correctWord = "begin",
      this.gameStatus = GameStatus.loading,
      this.attemptedUpto = 0,
      List<String>? words,
      List<String>? attempts}) {
    this.attempts = attempts ?? List.empty();
    this.words = words ?? List.empty();
  }

  GameState.update(GameState old,
      {GameStatus? gameStatus,
      String? correctWord,
      List<String>? words,
      int? attemptedUpto,
      List<String>? attempts})
      : this(old.settings,
            correctWord: correctWord ?? old.correctWord,
            gameStatus: gameStatus ?? old.gameStatus,
            words: words ?? old.words,
            attemptedUpto: attemptedUpto ?? old.attemptedUpto,
            attempts: attempts ?? old.attempts);
}

class GameStateNotifier extends StateNotifier<GameState> {
  Random rng = Random();

  GameStateNotifier(GameSettings settings) : super(GameState(settings));

  Future<void> resetWord() async {
    final useOldWords = (state.correctWord.length == state.settings.wordSize) &&
        state.words.isNotEmpty;
    final words =
        useOldWords ? state.words : await loadWords(state.settings.wordSize);
    state = GameState.update(state,
        attempts: List.empty(),
        words: words,
        correctWord: words[rng.nextInt(words.length)],
        gameStatus: GameStatus.started);
  }

  void updateCurrentAttempt(String character) {
    List<String> attempts = List.from(state.attempts, growable: true);
    // if this attempt has not even started
    if (state.attempts.length == state.attemptedUpto) {
      attempts.add("");
    }
    // if the word has been done
    if (attempts[state.attemptedUpto].length >= state.correctWord.length) {
      // TODO: check enter button
      attemptAnswer(attempts[state.attemptedUpto]);
    } else {
      attempts[state.attemptedUpto] += character;
      state = GameState.update(state, attempts: attempts);
    }
  }

  void attemptAnswer(String answer) {
    if (answer.length != state.correctWord.length) {
      throw WrongWordLengthException(state.correctWord.length);
    }
    state = GameState.update(state, attemptedUpto: state.attemptedUpto + 1);
  }
}

final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  final gameSettings = ref.watch(gameSettingsProvider);
  final notifier = GameStateNotifier(gameSettings);
  notifier.resetWord();
  return notifier;
});
