import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_model.g.dart';

typedef WordItem = ({String key, Set<TranslationModel> translations});

@JsonSerializable()
class NodeModel {
  final String nodeKey;
  @JsonKey(includeToJson: false, includeFromJson: true)
  final bool? isPanelExpanded;
  final List<WordItem> wordItems;

  NodeModel({
    required this.nodeKey,
    this.isPanelExpanded = false,
    required this.wordItems,
  });

  factory NodeModel.fromJson(Map<String, dynamic> json) =>
      _$NodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NodeModelToJson(this);

  NodeModel copyWith(
      {String? nodeKey, bool? isPanelExpanded, List<WordItem>? wordItems}) {
    return NodeModel(
      nodeKey: nodeKey ?? this.nodeKey,
      isPanelExpanded: isPanelExpanded ?? this.isPanelExpanded,
      wordItems: wordItems ?? this.wordItems,
    );
  }
}
