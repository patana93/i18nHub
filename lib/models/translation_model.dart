import 'package:flutter/material.dart';

@immutable
class TranslationModel {
  final String language;
  final String value;
  final bool isEqualToDefault;

  const TranslationModel({
    required this.language,
    required this.value,
    this.isEqualToDefault = false,
  });

  TranslationModel.fromJson(Map<String, dynamic> json)
      : language = json['language'],
        value = json['value'],
        isEqualToDefault = json["isEqualToDefault"];

  Map<String, dynamic> toJson() => {
        'language': language,
        'value': value,
        'isEqualToDefault': isEqualToDefault,
      };

  TranslationModel copyWith(
      {String? language, String? value, bool? isEqualToDefault}) {
    return TranslationModel(
      language: language ?? this.language,
      value: value ?? this.value,
      isEqualToDefault: isEqualToDefault ?? this.isEqualToDefault,
    );
  }

  @override
  String toString() {
    return "$language($isEqualToDefault) -> $value";
  }
}
