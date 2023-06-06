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
}
