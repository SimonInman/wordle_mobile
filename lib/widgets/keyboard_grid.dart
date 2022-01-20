import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/widgets/keyboard_key.dart';
import 'package:wordle_mobile/widgets/keyboard_key_del.dart';
import 'package:wordle_mobile/widgets/keyboard_key_enter.dart';

const ROW_1 = "QWERTYUIOP";
const ROW_2 = "ASDFGHJKL";
const ROW_3 = "ZXCVBNM";

class KeyboardGrid extends ConsumerWidget {
  const KeyboardGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            KeyboardKey("Q"),
            KeyboardKey("W"),
            KeyboardKey("E"),
            KeyboardKey("R"),
            KeyboardKey("T"),
            KeyboardKey("Y"),
            KeyboardKey("U"),
            KeyboardKey("I"),
            KeyboardKey("O"),
            KeyboardKey("P"),
          ],
        ),
        Row(mainAxisSize: MainAxisSize.min, children: const [
          KeyboardKey("A"),
          KeyboardKey("S"),
          KeyboardKey("D"),
          KeyboardKey("F"),
          KeyboardKey("G"),
          KeyboardKey("H"),
          KeyboardKey("J"),
          KeyboardKey("K"),
          KeyboardKey("L"),
        ]),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            KeyboardKeyEnter(),
            KeyboardKey("Z"),
            KeyboardKey("X"),
            KeyboardKey("C"),
            KeyboardKey("V"),
            KeyboardKey("B"),
            KeyboardKey("N"),
            KeyboardKey("M"),
            KeyboardKeyDel(),
          ],
        ),
      ],
    );
  }
}
