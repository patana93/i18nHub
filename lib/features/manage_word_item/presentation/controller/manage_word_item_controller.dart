import 'package:collection/collection.dart';
import 'package:i18n_app/features/manage_word_item/data/repository/word_item_repo.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manage_word_item_controller.g.dart';

@riverpod
class ManageWordItemController extends _$ManageWordItemController {
  final ManageWordItemRepo _manageWordItemRepo = ManageWordItemRepo();

  @override
  List<NodeModel> build() {
    return _manageWordItemRepo.getAllNodeItems();
  }

  NodeModel? getNodeItem(String? key) => _manageWordItemRepo.getNodeItem(key);

  filterData(String searchString) {
    state = _manageWordItemRepo.filterData(searchString);
  }

  void addNodeItem(String nodeKey) {
    _manageWordItemRepo.addNodeItem(nodeKey: nodeKey);
    state = [..._manageWordItemRepo.getAllNodeItems()];
  }

  void removeNodeItem(String nodeKey) {
    _manageWordItemRepo.removeNodeItem(nodeKey);
    state = [..._manageWordItemRepo.getAllNodeItems()];
    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(null, null);
  }

  void editNodeItem(String nodeKey, newNodeKey) {
    _manageWordItemRepo.editNodeItem(nodeKey, newNodeKey);
    state = [..._manageWordItemRepo.getAllNodeItems()];
  }

  void addWordItem(
      {required NodeModel nodeItem,
      required WordItem wordItem,
      String? searchString}) async {
    _manageWordItemRepo.addWordItem(
        nodeKey: nodeItem.nodeKey, wordItem: wordItem);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];

    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(nodeItem, wordItem);
  }

  void removeWordItem(
      {required String nodeKey,
      required String key,
      String? searchString}) async {
    _manageWordItemRepo.removeWordItem(nodeKey: nodeKey, key: key);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
  }

  void editWordItemKey(
      {required String oldKey,
      required NodeModel newNodeItem,
      required WordItem newWordItem,
      String? searchString}) async {
    _manageWordItemRepo.editWordItemKey(
        nodeKey: newNodeItem.nodeKey, oldKey: oldKey, newWordItem: newWordItem);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
    ref.read(selectionWordItemControllerProvider.notifier).selectWordItem(
        newNodeItem,
        getNodeItem(newNodeItem.nodeKey)
            ?.wordItems
            .firstWhere((element) => element.key == newWordItem.key));
  }

  bool checkWordItemKeyAlreadyExist({required String key}) =>
      _manageWordItemRepo.checkWordItemKeyAlreadyExist(key: key.toLowerCase());

  bool checkNodeItemKeyAlreadyExist({required String key}) =>
      _manageWordItemRepo.checkNodeItemKeyAlreadyExist(key: key.toLowerCase());

  void addTranslationLanguages(
      {required String newLanguage, String? searchString}) {
    _manageWordItemRepo.addTranslationLanguages(newLanguage: newLanguage);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
    final selectedWordItem = ref.read(selectionWordItemControllerProvider);
    final selectedNodeitem =
        ref.read(selectionWordItemControllerProvider.notifier).selectedNode;

    ref.read(selectionWordItemControllerProvider.notifier).selectWordItem(
        selectedNodeitem,
        getNodeItem(selectedNodeitem?.nodeKey)?.wordItems.firstWhereOrNull(
            (element) => element.key == (selectedWordItem?.key ?? "")));
  }

  void removeTranslation(
      {required String selectedLanguage, String? searchString}) {
    _manageWordItemRepo.removeTranslations(oldLanguage: selectedLanguage);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
  }

  void editWordTranslation({
    required NodeModel nodeItem,
    required String key,
    required TranslationModel newTranslation,
    bool? isEqualToDefault,
  }) {
    _manageWordItemRepo.editWordTranslation(
      nodeKey: nodeItem.nodeKey,
      key: key,
      newTranslation: newTranslation,
      isEqualToDefault: isEqualToDefault,
    );

    state = [..._manageWordItemRepo.getAllNodeItems()];
    ref.read(selectionWordItemControllerProvider.notifier).selectWordItem(
        nodeItem,
        getNodeItem(nodeItem.nodeKey)
            ?.wordItems
            .firstWhere((element) => element.key == key));
  }

  void clearAll() {
    _manageWordItemRepo.clearAll();
    state = [..._manageWordItemRepo.getAllNodeItems()];
  }

  setPanelExpansion(String? searchString, NodeModel nodeItem) {
    _manageWordItemRepo.toggleExpansion(nodeItem);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];

    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(nodeItem, null);
  }
}
