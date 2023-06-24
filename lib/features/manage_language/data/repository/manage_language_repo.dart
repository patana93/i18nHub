import 'package:i18n_hub/core/utils/languages_enum.dart';

typedef Language = ({String code, String name});

class ManageLanguageRepo {
  final List<Language> languages = [];

  List<Language> getAllLanguageSelected() {
    if (languages.isEmpty) {
      addLanguage(language: (
        code: LanguagesAvailable.english.code,
        name: LanguagesAvailable.english.name
      ));
    }
    return languages;
  }

  void addLanguage({required Language language}) {
    languages.add((code: language.code, name: language.name));
  }

  void removeLanguage({required String language}) {
    languages.removeWhere((element) => element.name == language);
  }

  void resetToDefault({required Language defaultLanguage}) {
    languages.clear();
    addLanguage(language: defaultLanguage);
  }

  void clear() {
    languages.clear();
  }
}
