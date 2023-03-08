// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      key: json['key'] as String,
      translations: (json['translations'] as List<dynamic>)
          .map((e) => TranslationModel.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      'key': instance.key,
      'translations': instance.translations.toList(),
    };
