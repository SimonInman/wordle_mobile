import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/providers/game_provider.dart';

class AnswerBox extends ConsumerWidget {
  AnswerBox({
    Key? key,
  }) : super(key: key);

  final TextEditingController answerController =
      TextEditingController.fromValue(TextEditingValue.empty);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: answerController,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {
          ref.read(gameStateProvider.notifier).attemptAnswer(value);
        },
        decoration: const InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          hintText: "answer",
        ),
      ),
    );
  }
}
