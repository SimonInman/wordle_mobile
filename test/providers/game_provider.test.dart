import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_mobile/providers/game_provider.dart';
import 'package:wordle_mobile/providers/settings_provider.dart';

void main() {
  test('game initialised with default word', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.listen(
        gameSettingsProvider, (GameSettings? previous, GameSettings next) {},
        fireImmediately: true);
    container.listen(
        gameStateProvider, (GameState? previous, GameState next) {},
        fireImmediately: true);

    expect(container.read(gameStateProvider).correctWord, "begin");
  });

  test('game settings change updates word',  () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.listen(
        gameSettingsProvider, (GameSettings? previous, GameSettings next) {},
        fireImmediately: true);
    container.listen(
        gameStateProvider, (GameState? previous, GameState next) {},
        fireImmediately: true);

    container.read(gameSettingsProvider.notifier).updateWordSize(4);
    expect(container.read(gameStateProvider).gameStatus, GameStatus.loading);

    await Future.delayed(const Duration(milliseconds: 200), (){});
    expect(container.read(gameStateProvider).correctWord == "begin", false);
    expect(container.read(gameStateProvider).gameStatus, GameStatus.started);

  });
}
