import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettings {
  final int wordSize;
  final int attemptsAllowed;

  GameSettings({this.wordSize = 5, this.attemptsAllowed = 6});
}

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier() : super(GameSettings());

  void updateWordSize(int newWordSize) {
    state = GameSettings(wordSize: newWordSize, attemptsAllowed: state.attemptsAllowed);
  }

  void updateAttemptsAllowed(int newAttemptsAllowed) {
    state = GameSettings(wordSize: state.wordSize, attemptsAllowed: newAttemptsAllowed);
  }
}

final gameSettingsProvider =
StateNotifierProvider<GameSettingsNotifier, GameSettings>(
        (ref) => GameSettingsNotifier());
