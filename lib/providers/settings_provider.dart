import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettings {
  final int wordSize;
  final int attemptsAllowed;

  GameSettings({this.wordSize = 5, this.attemptsAllowed = 10});

  GameSettings.update(GameSettings old, {int? wordSize, int? attemptsAllowed})
      : this(
            wordSize: wordSize ?? old.wordSize,
            attemptsAllowed: attemptsAllowed ?? old.attemptsAllowed);
}

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier() : super(GameSettings());

  void updateWordSize(int newWordSize) {
    state = GameSettings.update(state, wordSize: newWordSize);
  }

  void updateAttemptsAllowed(int newAttemptsAllowed) {
    state = GameSettings.update(state, attemptsAllowed: newAttemptsAllowed);
  }
}

final gameSettingsProvider =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>(
        (ref) => GameSettingsNotifier());
