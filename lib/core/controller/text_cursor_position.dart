import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'text_cursor_position.g.dart';

@riverpod
class TextCursorPositionNotifier extends _$TextCursorPositionNotifier {
  @override
  int build() {
    return 0;
  }

  setTextCursorPosition(int position) {
    state = position;
  }
}
