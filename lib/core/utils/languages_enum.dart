import 'package:collection/collection.dart';

enum LanguagesAvailable {
  albanian(code: "sq", name: "Albanian"),
  amharic(code: "am", name: "Amharic"),
  arabic(code: "ar", name: "Arabic"),
  basque(code: "eu", name: "Basque"),
  bengali(code: "bn", name: "Bengali"),
  bulgarian(code: "bg", name: "Bulgarian"),
  catalan(code: "ca", name: "Catalan"),
  chinese(code: "zh", name: "Chinese"),
  croatian(code: "hr", name: "Croatian"),
  czech(code: "cs", name: "Czech"),
  danish(code: "da", name: "Danish"),
  dutch(code: "nl", name: "Dutch"),
  english(code: "en", name: "English"),
  estonian(code: "et", name: "Estonian"),
  finnish(code: "fi", name: "Finnish"),
  french(code: "fr", name: "French"),
  galician(code: "gl", name: "Galician"),
  german(code: "de", name: "German"),
  greek(code: "el", name: "Greek"),
  hausa(code: "ha", name: "Hausa"),
  hungarian(code: "hu", name: "Hungarian"),
  icelandic(code: "is", name: "Icelandic"),
  igbo(code: "ig", name: "Igbo"),
  irish(code: "ga", name: "Irish"),
  italian(code: "it", name: "Italian"),
  japanese(code: "ja", name: "Japanese"),
  korean(code: "ko", name: "Korean"),
  latvian(code: "lv", name: "Latvian"),
  lithuanian(code: "lt", name: "Lithuanian"),
  maltese(code: "mt", name: "Maltese"),
  norwegian(code: "no", name: "Norwegian"),
  polish(code: "pl", name: "Polish"),
  portuguese(code: "pt", name: "Portuguese"),
  romanian(code: "ro", name: "Romanian"),
  russian(code: "ru", name: "Russian"),
  scottish(code: "gd", name: "Scottish Gaelic"),
  serbian(code: "sr", name: "Serbian"),
  slovak(code: "sk", name: "Slovak"),
  slovenian(code: "sl", name: "Slovenian"),
  spanish(code: "es", name: "Spanish"),
  swahili(code: "sw", name: "Swahili"),
  swedish(code: "sv", name: "Swedish"),
  turkish(code: "tr", name: "Turkish"),
  ukrainian(code: "uk", name: "Ukrainian"),
  vietnamese(code: "vi", name: "Vietnamese"),
  welsh(code: "cy", name: "Welsh"),
  yoruba(code: "yo", name: "Yoruba"),
  zulu(code: "zu", name: "Zulu");

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
