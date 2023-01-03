import 'package:flutter/material.dart';
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

  editWord(String oldKey, WordItem newWordItem) {
    removeWord(oldKey);
    addWord(newWordItem);
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

  bool checkKeyAlreadyExist(String key) {
    return state.map((e) => e.key).toList().any((element) => element == key);
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

@riverpod
class WordItemSelectedNotifier extends _$WordItemSelectedNotifier {
  @override
  WordItem? build() {
    return null;
  }

  selectWordItem(String key) {
    final list = ref.watch(wordItemNotifierProvider);
    state = list.firstWhere((wordItem) => wordItem.key == key);
  }
}
