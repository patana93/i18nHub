import 'package:i18n_hub/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_text_controller.g.dart';

@riverpod
class SearchTextController extends _$SearchTextController {
  @override
  String? build() {
    return null;
  }

  void setSearchText(String? searchText) {
    state = searchText ?? state ?? "";
    ref.read(manageWordItemControllerProvider.notifier).filterData();
  }
}
