class LoadFromJsonRepo {
  final List<String> _languages = [];

  List<String> getAllLanguageSelected() {
    return _languages;
  }

  void loadLanguage({required String language}) {
    _languages.add(language);
  }

  void removeLanguage({required String language}) {
    _languages.remove(language);
  }
}
