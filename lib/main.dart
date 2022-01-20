import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/widgets/answer_box.dart';
import 'package:wordle_mobile/widgets/keyboard_grid.dart';
import 'package:wordle_mobile/widgets/wordle_grid.dart';

import 'debug/provider_logger.dart';

void main() {
  runApp(ProviderScope(
    child: const MyApp(),
    observers: kDebugMode ? [ProviderLogger()] : [],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.grey,
          fontFamily: "Roboto Mono, Menlo, Inconsolata, Courier, monospace"),
      home: Scaffold(
          body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [AnswerBox(), const WordleGrid(), KeyboardGrid()],
      )),
    );
  }
}
