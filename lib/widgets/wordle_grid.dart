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
    final bool isWinner = gameState.attemptedUpto == 0 
    ? false 
    : gameState.attempts[gameState.attemptedUpto - 1] == gameState.correctWord;
    if (isWinner) {
      return Stack(children: [
        _build(context, ref),
        _winMessage(context, ref)
      ]);
    } 
    return _build(context, ref);
  }

  Widget _build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    List<Widget> rows = [];
    for (int i = 0; i < gameState.settings.attemptsAllowed; i++) {
      String answer = "";
      if (gameState.attempts.length > i) {
        answer = gameState.attempts[i];
      }
      rows.add(WordleRow(
          attempted: gameState.attemptedUpto > i,
          wordLength: gameState.settings.wordSize,
          answer: answer,
          correct: gameState.correctWord));
    }

    return Column(
      children: rows,
    );
  }

  _winMessage(BuildContext context, WidgetRef ref) { 
    //todo pass game state
    final gameState = ref.watch(gameStateProvider);
    return SizedBox(height: 200.0, width: 400.0, child: Container(color: Colors.blueAccent, 
    child: Column(children: [
      const Text('You Won!'),
      WordleRow(attempted: true, 
      wordLength: gameState.settings.wordSize, 
      answer: gameState.correctWord, correct: gameState.correctWord,)

    ],),)
   ,);
  }
}
