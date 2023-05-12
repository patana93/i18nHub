import 'package:i18n_app/features/manage_word_item/data/repository/word_item_repo.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/word_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manage_word_item_controller.g.dart';

@riverpod
class ManageWordItemController extends _$ManageWordItemController {
  final ManageWordItemRepo _manageWordItemRepo = ManageWordItemRepo();

  @override
  List<WordModel> build() {
    return _manageWordItemRepo.getAllWordItems();
  }

  WordModel? getWordItem(String key) => _manageWordItemRepo.getWordItem(key);

  filterData(String searchString) {
    state = _manageWordItemRepo.filterData(searchString);
  }

  void addWordItem({required WordModel wordItem, String? searchString}) async {
    _manageWordItemRepo.addWordItem(wordItem: wordItem);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(wordItem);
  }

  void removeWordItem({required String key, String? searchString}) async {
    _manageWordItemRepo.removeWordItem(key: key);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
  }

  void editWordItemKey(
      {required String oldKey,
      required WordModel newWordItem,
      String? searchString}) async {
    _manageWordItemRepo.editWordItemKey(
        oldKey: oldKey, newWordItem: newWordItem);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(newWordItem);
  }

  bool checkWordItemKeyAlreadyExist({required String key}) =>
      _manageWordItemRepo.checkWordItemKeyAlreadyExist(key: key.toLowerCase());

  void addTranslationLanguages(
      {required String newLanguage, String? searchString}) {
    _manageWordItemRepo.addTranslationLanguages(newLanguage);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
    final selectedWordItem = ref.read(selectionWordItemControllerProvider);

    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(getWordItem(selectedWordItem?.key ?? ""));
  }

  void removeTranslation(
      {required String selectedLanguage, String? searchString}) {
    _manageWordItemRepo.removeTranslations(selectedLanguage);
    state = [..._manageWordItemRepo.filterData(searchString ?? "")];
  }

  void editWordTranslation({
    required String key,
    required TranslationModel newTranslation,
    bool? isEqualToDefault,
  }) {
    _manageWordItemRepo.editWordTranslation(
      key: key,
      newTranslation: newTranslation,
      isEqualToDefault: isEqualToDefault,
    );

    state = [..._manageWordItemRepo.getAllWordItems()];
    ref
        .read(selectionWordItemControllerProvider.notifier)
        .selectWordItem(getWordItem(key));
  }

  void clearAll() {
    _manageWordItemRepo.clearAll();
    state = [..._manageWordItemRepo.getAllWordItems()];
  }
}
