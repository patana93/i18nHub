import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'word_item.g.dart';

@immutable
class WordItem {
  final String key;
  final Map<String, String> translations;

  const WordItem({
    required this.key,
    required this.translations,
  });
}

@riverpod
class WordItemNotifier extends _$WordItemNotifier {
  @override
  List<WordItem> build() {
    return [];
  }

  addWord(WordItem wordItem) {
    state = [...state, wordItem];
  }

  removeWord(String wordItemId) {
    state = [
      for (final word in state)
        if (wordItemId != word.key) word,
    ];
  }

  clearAll() {
    state = [];
  }
}

@riverpod
class WordItemFilteredNotifier extends _$WordItemFilteredNotifier {
  @override
  List<WordItem> build() {
    return ref.watch(wordItemNotifierProvider);
  }

  filterData(String searchString) {
    final list = ref.watch(wordItemNotifierProvider);
    state =
        list.where((wordItem) => wordItem.key.contains(searchString)).toList();
  }
}
