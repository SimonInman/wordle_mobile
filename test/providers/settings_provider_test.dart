
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wordle_mobile/providers/settings_provider.dart';

class GameSettingsListener extends Mock {
  void call(GameSettings? previous, GameSettings next);
}

void main () {
  test('game settings can be updated', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    final container = ProviderContainer();
    addTearDown(container.dispose);
    final gameSettingsListener = GameSettingsListener();

    container.listen(gameSettingsProvider, gameSettingsListener, fireImmediately: true);

    verify(gameSettingsListener(null, container.read(gameSettingsProvider))).called(1);

    container.read(gameSettingsProvider.notifier).updateWordSize(6);
    expect(container.read(gameSettingsProvider).wordSize, 6);

    container.read(gameSettingsProvider.notifier).updateAttemptsAllowed(4);
    expect(container.read(gameSettingsProvider).attemptsAllowed, 4);


  });

  test('game settings default values', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.listen(gameSettingsProvider, (GameSettings? previous, GameSettings next) {

    }, fireImmediately: true);

    expect(container.read(gameSettingsProvider).wordSize, 5);

    expect(container.read(gameSettingsProvider).attemptsAllowed, 6);

  });
}