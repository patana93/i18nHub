// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationModel _$TranslationModelFromJson(Map<String, dynamic> json) =>
    TranslationModel(
      languageName: json['languageName'] as String,
      value: json['value'] as String,
      isEqualToDefault: json['isEqualToDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$TranslationModelToJson(TranslationModel instance) =>
    <String, dynamic>{
      'languageName': instance.languageName,
      'value': instance.value,
      'isEqualToDefault': instance.isEqualToDefault,
    };
