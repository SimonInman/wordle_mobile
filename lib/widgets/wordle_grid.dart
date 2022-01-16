import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/providers/game_provider.dart';
import 'package:wordle_mobile/widgets/wordle_row.dart';

class WordleGrid extends ConsumerWidget {
  const WordleGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    List<Widget> rows = [];
    for (int i = 0; i < gameState.settings.attemptsAllowed; i++) {
      String answer = "";
      if (i < gameState.attempts.length) {
        answer = gameState.attempts[i];
      }
      rows.add(WordleRow(
          wordLength: gameState.settings.wordSize,
          answer: answer,
          correct: gameState.correctWord));
    }

    return Column(
      children: rows,
    );
  }
}
