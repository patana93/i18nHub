import 'package:collection/collection.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selection_word_item_controller.g.dart';

@riverpod
class SelectionWordItemController extends _$SelectionWordItemController {
  NodeModel? _selectedNode;

  @override
  WordItem? build() {
    return null;
  }

  void selectWordItem(NodeModel? nodeItem, WordItem? wordItem) {
    if (nodeItem == null) {
      state = null;
      return;
    }
    _selectedNode = nodeItem;
    state = ref
        .read(manageWordItemControllerProvider.notifier)
        .getNodeItem(nodeItem.nodeKey)
        ?.wordItems
        .firstWhereOrNull((element) => element.key == (wordItem?.key ?? ""));
  }

  NodeModel? get selectedNode => _selectedNode;
}
