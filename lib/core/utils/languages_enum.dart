//TODO Evalutate to use enum
/* class Const {
  static const Map<String, String> language = {
    "English": "en",
    "Italian": "it",
    "Spanish": "es",
    "French": "fr",
  };


} */

enum LanguagesAvailable {
  english(code: "en", language: "English"),
  italian(code: "it", language: "Italian"),
  spanish(code: "es", language: "Spanish"),
  french(code: "fr", language: "French");

  const LanguagesAvailable({
    required this.code,
    required this.language,
  });

  final String code;
  final String language;
}
