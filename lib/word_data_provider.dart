import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_mobile/word_data.dart';

final wordDataProvider = StateNotifierProvider<WordData, List<String>>((ref) {
  return WordData([]);
});
