import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_edit_text_focus_controller.g.dart';

@riverpod
class TranslationEditTextFocusNotifier
    extends _$TranslationEditTextFocusNotifier {
  @override
  int? build() {
    return null;
  }

  setEdtiTextIndex(int index) {
    state = index;
  }
}
