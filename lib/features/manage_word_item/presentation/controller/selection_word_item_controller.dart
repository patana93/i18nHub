import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/model/word_model.dart';

part 'selection_word_item_controller.g.dart';

@riverpod
class SelectionWordItemController extends _$SelectionWordItemController {
  @override
  WordModel? build() {
    return null;
  }

  void selectWordItem(WordModel? wordItem) {
    state = ref
        .read(manageWordItemControllerProvider.notifier)
        .getWordItem(wordItem?.key ?? "");
  }
}
