import 'dart:math';

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
  GameStateNotifier(GameSettings settings) : super(GameState(settings));

  Future<void> resetWord() async {
    final useOldWords = (state.correctWord.length == state.settings.wordSize) &&
        state.words.isNotEmpty;
    final words =
        useOldWords ? state.words : await loadWords(state.settings.wordSize);
    state = GameState.update(state,
        attempts: List.empty(),
        words: words,
        correctWord: _wordOfTheDay(words),
        gameStatus: GameStatus.started);
  }

/// Provides a psuedorandom but deterministic word based on the date of the local time.
String _wordOfTheDay(List<String> deterministicallyShuffledWords) {
  final nowLocalTime = DateTime.now();
  final fixedTimeLocalTime = DateTime(2001);

  final index = daysBetween(fixedTimeLocalTime, nowLocalTime) % deterministicallyShuffledWords.length;
  return deterministicallyShuffledWords[index];
}

  void updateCurrentAttempt(String character) {
    List<String> attempts = List.from(state.attempts, growable: true);
    // if this attempt has not even started
    if (state.attempts.length == state.attemptedUpto) {
      attempts.add("");
    }
    // if the word has been done
    if (character == "ENTER") {
      if (attempts[state.attemptedUpto].length != state.correctWord.length) {
        // toast to complete word maybe?
      } else {
        attemptAnswer(attempts[state.attemptedUpto]);
      }
      return;


    } else if (character == "DEL") {
      int splitTo = attempts[state.attemptedUpto].length - 1;
      if (splitTo < 0) {
        splitTo = 0;
      }
      attempts[state.attemptedUpto] =
          attempts[state.attemptedUpto].substring(0, splitTo);


    } else {
      if (attempts[state.attemptedUpto].length >= state.correctWord.length) {
        // toast that no more letters possible maybe?
      } else {
        attempts[state.attemptedUpto] += character;
      }
    }
    state = GameState.update(state, attempts: attempts);
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

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
