// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeModel _$NodeModelFromJson(Map<String, dynamic> json) => NodeModel(
      nodeKey: json['nodeKey'] as String,
      wordItems: (json['wordItems'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  key: $jsonValue['key'] as String,
                  translations: ($jsonValue['translations'] as List<dynamic>)
                      .map((e) =>
                          TranslationModel.fromJson(e as Map<String, dynamic>))
                      .toSet(),
                ),
              ))
          .toList(),
    );

Map<String, dynamic> _$NodeModelToJson(NodeModel instance) => <String, dynamic>{
      'nodeKey': instance.nodeKey,
      'wordItems': instance.wordItems
          .map((e) => {
                'key': e.key,
                'translations': e.translations.toList(),
              })
          .toList(),
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
