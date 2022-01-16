import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/data/wordlist_repo.dart';
import 'package:wordle_mobile/providers/settings_provider.dart';

enum GameStatus { loading, started, win, lose }

class GameState {
  GameSettings settings;
  GameStatus gameStatus = GameStatus.loading;
  String correctWord;
  List<String> attempts = List.empty(growable: true);

  GameState(this.settings, {this.correctWord = "begin"});
}

class GameStateNotifier extends StateNotifier<GameState> {
  Random rng = Random();
  GameStateNotifier(GameSettings settings) : super(GameState(settings));

  Future<void> nextWord() async {
    final words = await loadWords(state.settings.wordSize);
    state.correctWord = words[rng.nextInt(words.length)];
    state.gameStatus = GameStatus.started;
  }

}

final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  final gameSettings = ref.watch(gameSettingsProvider);
  final notifier = GameStateNotifier(gameSettings);
  notifier.nextWord();
  return notifier;
});
