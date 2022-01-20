import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wordle_mobile/providers/game_provider.dart';
import 'package:wordle_mobile/providers/settings_provider.dart';

class GameStateListener extends Mock {
  void call(GameState? previous, GameState next);
}
class GameSettingsListener extends Mock {
  void call(GameSettings? previous, GameSettings next);
}

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
    // addTearDown(container.dispose);
    final gameSettingsListener = GameSettingsListener();
    final gameStateListener = GameStateListener();

    container.listen(
        gameSettingsProvider, gameSettingsListener,
        fireImmediately: true);
    container.listen(
        gameStateProvider, gameStateListener,
        fireImmediately: true);
    await Future.delayed(const Duration(milliseconds: 100), (){});

    verify(gameSettingsListener(null, container.read(gameSettingsProvider))).called(1);
    verifyNoMoreInteractions(gameSettingsListener);

    final oldGameState =  container.read(gameStateProvider);
    container.read(gameSettingsProvider.notifier).updateWordSize(4);
    expect(container.read(gameStateProvider).gameStatus, GameStatus.loading);

    verify(gameStateListener(oldGameState, container.read(gameStateProvider))).called(1);

    await Future.delayed(const Duration(milliseconds: 100), (){});

    expect(container.read(gameStateProvider).correctWord == "begin", false);
    expect(container.read(gameStateProvider).gameStatus, GameStatus.started);
  });
}
