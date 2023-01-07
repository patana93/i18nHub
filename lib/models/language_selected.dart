import 'package:i18n_app/utils/const.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_selected.g.dart';

@riverpod
class LanguageSelectedNotifier extends _$LanguageSelectedNotifier {
  @override
  Set<String> build() {
    return {Const.language.first};
  }

  addLanguage(String language) {
    state = {...state, language};
  }

  removeLanguage(String languageName) {
    state = {
      for (final language in state)
        if (languageName != language) language,
    };
  }

  clearAll() {
    state = {};
  }
}
