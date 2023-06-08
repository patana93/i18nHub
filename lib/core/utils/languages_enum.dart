import 'package:collection/collection.dart';

enum LanguagesAvailable {
  english(code: "en", name: "English"),
  italian(code: "it", name: "Italian"),
  spanish(code: "es", name: "Spanish"),
  french(code: "fr", name: "French");

  const LanguagesAvailable({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;

  static String getLanguageName(String languageCode) =>
      LanguagesAvailable.values
          .firstWhereOrNull((element) => element.code == languageCode)
          ?.name ??
      "Invalid code";

  static String getLanguageCode(String languageName) =>
      LanguagesAvailable.values
          .firstWhereOrNull((element) => element.name == languageName)
          ?.code ??
      "Invalid name";
}
