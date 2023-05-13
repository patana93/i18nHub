import 'package:i18n_app/utils/const.dart';

class ManageLanguageRepo {
  //final Set<String> languages = {"English", "French", "Italian", "Spanish"};
  final Set<String> languages = {};

  Set<String> getAllLanguageSelected() {
    if (languages.isEmpty) addLanguage(language: Const.language.first);
    return languages;
  }

  void addLanguage({required String language}) {
    languages.add(language);
  }

  void removeLanguage({required String language}) {
    languages.remove(language);
  }

  void resetToDefault({required String defaultLanguage}) {
    languages.clear();
    addLanguage(language: defaultLanguage);
  }

  void clear() {
    languages.clear();
  }
}
