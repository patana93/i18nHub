import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translation_model.g.dart';

@JsonSerializable()
class TranslationModel extends Equatable {
  final String language;
  final String value;
  final bool isEqualToDefault;

  const TranslationModel({
    required this.language,
    required this.value,
    this.isEqualToDefault = false,
  });

  //Json Serializable
  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      _$TranslationModelFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationModelToJson(this);

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

  @override
  List<Object?> get props => [language, value, isEqualToDefault];
}
