import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/word_model.dart';
import 'package:collection/collection.dart';

class ManageWordItemRepo {
  //final List<WordModel> wordItems = List.generate(
  //    5500,
  //    (index) => WordModel(key: index.toString(), translations: {
  //          TranslationModel(language: "English", value: index.toString()),
  //          TranslationModel(language: "French", value: index.toString()),
  //          TranslationModel(language: "Italian", value: index.toString()),
  //          TranslationModel(language: "Spanish", value: index.toString())
  //        }));
  final List<WordModel> wordItems = [];

  List<WordModel> getAllWordItems() => wordItems;

  WordModel? getWordItem(String key) =>
      wordItems.firstWhereOrNull((wordItem) => wordItem.key == key);

  void addWordItem({required WordModel wordItem}) => wordItems.add(wordItem);

  void removeWordItem({required String key}) => wordItems.removeWhere(
        (element) => element.key == key,
      );

  editWordItemKey({required String oldKey, required WordModel newWordItem}) {
    removeWordItem(key: oldKey);
    addWordItem(wordItem: newWordItem);
  }

  bool checkWordItemKeyAlreadyExist({required String key}) => wordItems
      .map((e) => e.key)
      .toList()
      .any((element) => element.toLowerCase() == key.toLowerCase());

  List<WordModel> filterData(String searchString) {
    return wordItems
        .where((wordItem) => wordItem.key.contains(searchString))
        .toList();
  }

  void addTranslationLanguages(String newLanguage) {
    final List<WordModel> tempList = [];
    tempList.addAll(wordItems);
    clearAll();
    wordItems.addAll(tempList
        .map((wordItem) => wordItem.copyWith(translations: {
              ...wordItem.translations,
              TranslationModel(language: newLanguage, value: "")
            }))
        .toList());
  }

  void removeTranslations(String oldLanguage) {
    final List<WordModel> tempList = [];
    tempList.addAll(wordItems);
    wordItems.clear();
    wordItems.addAll(tempList
        .map(
          (e) => e.copyWith(translations: {
            for (final translation in e.translations)
              if (translation.language != oldLanguage) translation
          }),
        )
        .toList());
  }

  editWordTranslation(
      {required String key,
      required TranslationModel newTranslation,
      bool? isEqualToDefault}) {
    final wordItem = getWordItem(key)!;
    final int index =
        wordItems.indexWhere((element) => element.key == wordItem.key);
    final List<WordModel> iterable = [
      ...wordItems.sublist(0, index),
      wordItems[index].copyWith(translations: {
        for (final translation in wordItem.translations)
          if (translation.language == newTranslation.language)
            newTranslation.copyWith(
                language: newTranslation.language,
                value: newTranslation.value,
                isEqualToDefault:
                    isEqualToDefault ?? translation.isEqualToDefault)
          else
            translation
      }),
      ...wordItems.sublist(index + 1),
    ];
    clearAll();
    wordItems.addAll(iterable);
  }

  clearAll() => wordItems.clear();
}
