import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_model.g.dart';

typedef WordItem = ({String key, Set<TranslationModel> translations});

@JsonSerializable()
class NodeModel {
  final String nodeKey;
  final List<WordItem> wordItems;

  NodeModel({
    required this.nodeKey,
    required this.wordItems,
  });

  factory NodeModel.fromJson(Map<String, dynamic> json) =>
      _$NodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NodeModelToJson(this);
}

  

/*   NodeModel copyWith({String? nodeKey, List<WordModel>? wordModelList}) {
    return NodeModel(
      nodeKey: nodeKey ?? this.nodeKey,
      wordModelList: wordModelList ?? this.wordModelList,
    );
  } */

/*   @override
  String toString() {
    return "NodeModel nodeKey: $nodeKey -> $wordModelList";
  } */
