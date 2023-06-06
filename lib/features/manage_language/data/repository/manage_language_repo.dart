import 'package:i18n_app/core/utils/languages_enum.dart';

class ManageLanguageRepo {
  //final Set<String> languages = {"English", "French", "Italian", "Spanish"};
  final Map<String, String> languages = {};

  Map<String, String> getAllLanguageSelected() {
    if (languages.isEmpty) {
      addLanguage(
          language: MapEntry(LanguagesAvailable.english.language,
              LanguagesAvailable.english.code));
    }
    return languages;
  }

  void addLanguage({required MapEntry<String, String> language}) {
    languages[language.key] = language.value;
  }

  void removeLanguage({required String language}) {
    languages.remove(language);
  }

  void resetToDefault({required MapEntry<String, String> defaultLanguage}) {
    languages.clear();
    addLanguage(language: defaultLanguage);
  }

  void clear() {
    languages.clear();
  }
}
