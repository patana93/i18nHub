// 1. add the necessary imports
import 'package:i18n_app/features/manage_language/data/repository/manage_language_repo.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manage_language_controller.g.dart';

@riverpod
class ManageLanguageController extends _$ManageLanguageController {
  final ManageLanguageRepo _manageLanguageRepo = ManageLanguageRepo();

  @override
  Set<String> build() {
    return _manageLanguageRepo.getAllLanguageSelected();
  }

  void addLanguage({required String selectedLanguage}) async {
    _manageLanguageRepo.addLanguage(language: selectedLanguage);

    ref
        .read(manageWordItemControllerProvider.notifier)
        .addTranslationLanguages(newLanguage: selectedLanguage);

    state = {..._manageLanguageRepo.getAllLanguageSelected()};
  }

  void removeLanguage({required String selectedLanguage}) async {
    _manageLanguageRepo.removeLanguage(language: selectedLanguage);
    state = {..._manageLanguageRepo.getAllLanguageSelected()};
  }

  void resetToDefault({required String defaultLanguage}) async {
    _manageLanguageRepo.resetToDefault(defaultLanguage: defaultLanguage);
    state = {..._manageLanguageRepo.getAllLanguageSelected()};
  }

  void clear() {
    _manageLanguageRepo.clear();
    state = {};
  }
}
