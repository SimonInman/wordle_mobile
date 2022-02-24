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

    final isWinner = isWinningGame(gameState);
    if (isWinner) {
      return Stack(
        alignment:  Alignment.center,
        children: [
        _build(context, ref),
        _winMessage(context, gameState)
      ]);
    } 
  
    if (isLosingGame(gameState)) {
      return Stack(
        alignment:  Alignment.center,
        children: [
        _build(context, ref),
        _loseMessage(context, gameState)
      ]);
    }

    return _build(context, ref);
  }

  bool isWinningGame(GameState gameState) {
    return gameState.attemptedUpto == 0 
    ? false 
    : gameState.attempts[gameState.attemptedUpto - 1] == gameState.correctWord;
  }

  bool isLosingGame(GameState gameState) {
    return gameState.attemptedUpto == 0 
    ? false 
    : gameState.attemptedUpto == gameState.settings.attemptsAllowed;
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

  _winMessage(BuildContext context, GameState gameState) { 
    return _endOfGameMessage(gameState, 'You Won!');
  }

  _loseMessage(BuildContext context, GameState gameState) { 
    return _endOfGameMessage(gameState, 'You Lose!');
  }

  SizedBox _endOfGameMessage(GameState gameState, String userMessage) {
    return SizedBox(height: 200.0, width: 400.0, child: Container(color: Colors.blueAccent, 
  child: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text(userMessage, style: TextStyle( fontSize: 50.0)),
      WordleRow(attempted: true,
        wordLength: gameState.settings.wordSize,
        answer: gameState.correctWord, 
        correct: gameState.correctWord)
    ]),
  ))
 );
  }
}
