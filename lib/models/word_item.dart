import 'package:flutter/material.dart';
import 'package:i18n_app/models/language_selected.dart';
import 'package:i18n_app/models/translation_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'word_item.g.dart';

@immutable
class WordModel {
  final String key;
  final List<TranslationModel> translations;

  const WordModel({
    required this.key,
    required this.translations,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(key: json['key'], translations: [
      for (final translation in json["translations"])
        TranslationModel.fromJson(translation)
    ]);
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'translations': translations,
      };

  WordModel copyWith({String? key, List<TranslationModel>? translations}) {
    return WordModel(
      key: key ?? this.key,
      translations: translations ?? this.translations,
    );
  }

  @override
  String toString() {
    return "WordItem key: $key -> ${translations.join(", ")}";
  }
}

@riverpod
class WordNotifier extends _$WordNotifier {
  @override
  List<WordModel> build() {
    return [];
  }

  addWord(WordModel wordItem) {
    state = [
      ...state,
      wordItem.copyWith(
          translations: wordItem.translations.isNotEmpty
              ? wordItem.translations
              : [
                  for (final lang in ref.read(languageSelectedNotifierProvider))
                    TranslationModel(language: lang, value: "")
                ])
    ];
  }

  editWordKey(String oldKey, WordModel newWordItem) {
    removeWord(oldKey);
    addWord(newWordItem);
  }

  removeWord(String wordItemId) {
    state = [
      for (final word in state)
        if (wordItemId != word.key) word,
    ];
  }

  addTranslation(String newLanguage) {
    state = state
        .map(
          (e) => e.copyWith(translations: [
            ...e.translations,
            TranslationModel(language: newLanguage, value: "")
          ]),
        )
        .toList();
  }

  removeTranslation(String oldLanguage) {
    state = state
        .map(
          (e) => e.copyWith(translations: [
            for (final translation in e.translations)
              if (translation.language != oldLanguage) translation
          ]),
        )
        .toList();
  }

  editWordTranslation(
      {required WordModel wordItem,
      required TranslationModel newTranslation,
      bool? isEqualToDefault}) {
    final int index =
        state.indexWhere((element) => element.key == wordItem.key);
    state = [
      ...state.sublist(0, index),
      state[index].copyWith(translations: [
        for (final translation in state[index].translations)
          if (translation.language == newTranslation.language ||
              translation.isEqualToDefault)
            newTranslation.copyWith(
                language: translation.language,
                value: newTranslation.value,
                isEqualToDefault:
                    isEqualToDefault ?? translation.isEqualToDefault)
          else
            translation
      ]),
      ...state.sublist(index + 1),
    ];
    ref
        .read(wordItemSelectedNotifierProvider.notifier)
        .selectWordItem(wordItem.key);
  }

  bool checkKeyAlreadyExist(String key) {
    return state.map((e) => e.key).toList().any((element) => element == key);
  }

  clearAll() {
    state = [];
  }
}

@riverpod
class WordItemFilteredNotifier extends _$WordItemFilteredNotifier {
  @override
  List<WordModel> build() {
    return ref.watch(wordNotifierProvider);
  }

  filterData(String searchString) {
    final list = ref.watch(wordNotifierProvider);
    state =
        list.where((wordItem) => wordItem.key.contains(searchString)).toList();
  }
}

@riverpod
class WordItemSelectedNotifier extends _$WordItemSelectedNotifier {
  @override
  WordModel? build() {
    return null;
  }

  selectWordItem(String key) {
    final list = ref.watch(wordNotifierProvider);
    state = list.firstWhere((wordItem) => wordItem.key == key);
  }
}
