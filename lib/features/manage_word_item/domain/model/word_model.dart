import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';

@immutable
class WordModel extends Equatable {
  final String key;
  final Set<TranslationModel> translations;

  const WordModel({
    required this.key,
    required this.translations,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(key: json['key'], translations: {
      for (final translation in json["translations"])
        TranslationModel.fromJson(translation)
    });
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'translations': translations,
      };

  WordModel copyWith({String? key, Set<TranslationModel>? translations}) {
    return WordModel(
      key: key ?? this.key,
      translations: translations ?? this.translations,
    );
  }

  @override
  String toString() {
    return "WordItem key: $key -> ${translations.join(", ")}";
  }

  @override
  List<Object?> get props => [key, translations];
}
