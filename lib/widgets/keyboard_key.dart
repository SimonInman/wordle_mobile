import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/providers/game_provider.dart';

class KeyboardKey extends ConsumerWidget {
  final String letter;

  const KeyboardKey(
    this.letter, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          ref.read(gameStateProvider.notifier).updateCurrentAttempt(letter);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(color: Colors.grey, width: 2.0)),
          padding: const EdgeInsets.all(8.0),
          width: min(width / 12, 42),
          child: Text(
            letter,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: min(width / 24, 22),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
