import 'package:i18n_hub/core/utils/shared_prefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_file_controller.g.dart';

@riverpod
class CurrentFileController extends _$CurrentFileController {
  @override
  String? build() {
    return null;
  }

  void setCurrentFile(String fileName) {
    SharedPrefs.setString(SharedPrefs.currentFile, fileName);
    state = fileName;
  }

  void removeLanguage() {
    SharedPrefs.removeKey(SharedPrefs.currentFile);
    state = null;
  }
}
