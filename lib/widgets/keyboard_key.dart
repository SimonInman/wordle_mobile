import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  final String letter;

  const KeyboardKey(
    this.letter, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(color: Colors.grey, width: 2.0)),
          padding: const EdgeInsets.all(8.0),
          width: 42,
          child: Text(
            letter,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
