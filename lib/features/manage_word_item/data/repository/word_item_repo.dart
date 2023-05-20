import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:collection/collection.dart';

class ManageWordItemRepo {
  //final List<WordItem> wordItems = List.generate(
  //    5500,
  //    (index) => WordItem(key: index.toString(), translations: {
  //          TranslationModel(language: "English", value: index.toString()),
  //          TranslationModel(language: "French", value: index.toString()),
  //          TranslationModel(language: "Italian", value: index.toString()),
  //          TranslationModel(language: "Spanish", value: index.toString())
  //        }));
  final List<NodeModel> nodeItems = [
    NodeModel(nodeKey: "Main Node", wordItems: [])
  ];

  List<NodeModel> getAllNodeItems() => nodeItems;

  NodeModel? getNodeItem(String? key) =>
      nodeItems.firstWhereOrNull((element) => element.nodeKey == key);

  void addNodeItem(String nodeKey) {
    nodeItems.add(NodeModel(nodeKey: nodeKey, wordItems: []));
    sortNode();
  }

  void addWordItem({required String nodeKey, required WordItem wordItem}) {
    nodeItems
        .firstWhere((element) => element.nodeKey == nodeKey)
        .wordItems
        .add(wordItem);
    sortWordItem();
  }

  void sortNode() {
    nodeItems.sort(
        (a, b) => a.nodeKey.toLowerCase().compareTo(b.nodeKey.toLowerCase()));
  }

  void sortWordItem() {
    for (var element in nodeItems) {
      element.wordItems.sortByCompare((element) => element,
          (a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));
    }
  }

  void removeWordItem({required String nodeKey, required String key}) {
    nodeItems
        .firstWhere((element) => element.nodeKey == nodeKey)
        .wordItems
        .removeWhere(
          (element) => element.key == key,
        );
    sortWordItem();
  }

  editWordItemKey(
      {required String nodeKey,
      required String oldKey,
      required WordItem newWordItem}) {
    removeWordItem(nodeKey: nodeKey, key: oldKey);
    addWordItem(nodeKey: nodeKey, wordItem: newWordItem);
  }

  bool checkWordItemKeyAlreadyExist({required String key}) =>
      nodeItems.any((element) => element.wordItems
          .map((e) => e.key)
          .toList()
          .any((element) => element.toLowerCase() == key.toLowerCase()));

  List<NodeModel> filterData(String searchString) {
    if (searchString.isEmpty) {
      return nodeItems;
    }
    final List<NodeModel> filteredData = [];

    for (var node in nodeItems) {
      for (var wordItem in node.wordItems) {
        if (wordItem.key.contains(searchString)) {
          filteredData.add(node);
        }
      }
    }

    return filteredData;
  }

  void addTranslationLanguages({required String newLanguage}) {
    final List<NodeModel> tempList = [];
    tempList.addAll(nodeItems);

    nodeItems.clear();

    for (var item in tempList) {
      nodeItems.add(NodeModel(
          nodeKey: item.nodeKey,
          wordItems: item.wordItems
              .map((wordItem) => ((
                    key: wordItem.key,
                    translations: {
                      ...wordItem.translations,
                      TranslationModel(language: newLanguage, value: "")
                    }
                  )))
              .toList()));
    }
  }

  void removeTranslations({required String oldLanguage}) {
    final List<NodeModel> tempList = [];
    tempList.addAll(nodeItems);
    nodeItems.clear();
    for (var item in tempList) {
      nodeItems.add(NodeModel(
          nodeKey: item.nodeKey,
          wordItems: item.wordItems
              .map(
                (e) => (
                  key: "m",
                  translations: {
                    for (final translation in e.translations)
                      if (translation.language != oldLanguage) translation
                  }
                ),
              )
              .toList()));
    }
  }

  editWordTranslation(
      {required String nodeKey,
      required String key,
      required TranslationModel newTranslation,
      bool? isEqualToDefault}) {
    final wordItem = getNodeItem(nodeKey)!
        .wordItems
        .firstWhere((element) => element.key == key);

    final int index = nodeItems
        .firstWhere((element) => element.nodeKey == nodeKey)
        .wordItems
        .toList()
        .indexWhere((element) => element.key == key);

    final List<WordItem> iterable = [
      ...nodeItems
          .firstWhere((element) => element.nodeKey == nodeKey)
          .wordItems
          .sublist(0, index),

      /* nodeItems
          .firstWhere((element) => element.nodeKey == nodeKey)
          .wordItems[index]
          .copyWith(translations: {
        for (final translation in wordItem.translations)
          if (translation.language == newTranslation.language)
            newTranslation.copyWith(
                language: newTranslation.language,
                value: newTranslation.value,
                isEqualToDefault:
                    isEqualToDefault ?? translation.isEqualToDefault)
          else
            translation
      }), */

      (
        key: wordItem.key,
        translations: {
          for (final translation in wordItem.translations)
            if (translation.language == newTranslation.language)
              newTranslation.copyWith(
                  language: newTranslation.language,
                  value: newTranslation.value,
                  isEqualToDefault:
                      isEqualToDefault ?? translation.isEqualToDefault)
            else
              translation
        }
      ),
      ...nodeItems
          .firstWhere((element) => element.nodeKey == nodeKey)
          .wordItems
          .sublist(index + 1),
    ];
    nodeItems
        .firstWhere((element) => element.nodeKey == nodeKey)
        .wordItems
        .clear();
    nodeItems
        .firstWhere((element) => element.nodeKey == nodeKey)
        .wordItems
        .addAll(iterable);
  }

  clearAll() => nodeItems.clear();
}
