import 'package:collection/collection.dart';
import 'package:i18n_hub/features/manage_word_item/data/repository/word_item_repo.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/search_text_controller.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
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

  filterData() {
    final searchText = ref.watch(searchTextControllerProvider);
    state = [..._manageWordItemRepo.filterData(searchText ?? "")];
  }

  void addNodeItem(String nodeKey) {
    _manageWordItemRepo.addNodeItem(nodeKey: nodeKey);
    filterData();
  }

  void removeNodeItem(String nodeKey) {
    _manageWordItemRepo.removeNodeItem(nodeKey);
    filterData();
    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(null, null);
  }

  void editNodeItem(
      {required String nodeKey, required String newNodeKey, bool? isExpanded}) {
    _manageWordItemRepo.editNodeItem(
        nodeKey: nodeKey, newNodeKey: newNodeKey, isExpanded: isExpanded);
    filterData();
  }

  void addWordItem(
      {required NodeModel nodeItem, required WordItem wordItem}) async {
    _manageWordItemRepo.addWordItem(
        nodeKey: nodeItem.nodeKey, wordItem: wordItem);
    filterData();
    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(nodeItem, wordItem);
  }

  void removeWordItem(
      {required String nodeKey,
      required String key,
      String? searchString}) async {
    _manageWordItemRepo.removeWordItem(nodeKey: nodeKey, key: key);
    filterData();
  }

  void editWordItemKey(
      {required String oldKey,
      required NodeModel newNodeItem,
      required WordItem newWordItem,
      String? searchString}) async {
    _manageWordItemRepo.editWordItemKey(
        nodeKey: newNodeItem.nodeKey, oldKey: oldKey, newWordItem: newWordItem);
    filterData();
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
      {required String newLanguage,
      TranslationModel? translationModel,
      String? searchString}) {
    _manageWordItemRepo.addTranslationLanguages(
        newLanguage: newLanguage, translationModel: translationModel);
    filterData();
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

    filterData();
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

  togglePanelExpansion(NodeModel nodeItem) {
    _manageWordItemRepo.toggleExpansion(nodeItem);

    filterData();

    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(nodeItem, null);
  }
}
