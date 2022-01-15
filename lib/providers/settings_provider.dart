import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettings {
  int wordSize;
  int attemptsAllowed;

  GameSettings({this.wordSize = 5, this.attemptsAllowed = 6});
}

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier() : super(GameSettings());

  void updateWordSize(int newWordSize) {
    state.wordSize = newWordSize;
  }

  void updateAttemptsAllowed(int newAttemptsAllowed) {
    state.attemptsAllowed = newAttemptsAllowed;
  }
}

final gameSettingsProvider =
StateNotifierProvider<GameSettingsNotifier, GameSettings>(
        (ref) => GameSettingsNotifier());
