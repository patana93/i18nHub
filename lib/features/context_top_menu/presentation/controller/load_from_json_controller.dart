import 'package:i18n_hub/features/context_top_menu/data/repository/load_from_json_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'load_from_json_controller.g.dart';

@riverpod
class LoadFromJsonController extends _$LoadFromJsonController {
  final LoadFromJsonRepo _loadFromJsonRepo = LoadFromJsonRepo();
  @override
  List<String> build() {
    return [];
  }

  void loadLanguage(String language) {
    _loadFromJsonRepo.loadLanguage(language: language);
    state = _loadFromJsonRepo.getAllLanguageSelected();
  }

  void removeLanguage(String language) {
    _loadFromJsonRepo.removeLanguage(language: language);
    state = _loadFromJsonRepo.getAllLanguageSelected();
  }
}
