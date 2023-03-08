import 'package:equatable/equatable.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word_model.g.dart';

@JsonSerializable()
class WordModel extends Equatable {
  final String key;
  final Set<TranslationModel> translations;

  const WordModel({
    required this.key,
    required this.translations,
  });

  //Json Serializable
  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);

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
