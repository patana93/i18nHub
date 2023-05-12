import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_focus_controller.g.dart';

@riverpod
class SearchFocusController extends _$SearchFocusController {
  @override
  bool build() {
    return false;
  }

  void setFocusColor(bool isFocus) {
    state = isFocus;
  }
}
