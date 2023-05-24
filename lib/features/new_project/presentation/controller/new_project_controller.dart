// 1. add the necessary imports
import 'package:i18n_app/features/new_project/domain/repository/new_project_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_project_controller.g.dart';

@riverpod
class MakeNewProjectController extends _$MakeNewProjectController {
  @override
  void build() {}

  void makeNewProject({required String selectedLanguage}) async {
    final newProjectRepo = ref.read(makeNewProjectRepositoryProvider);

    state = newProjectRepo.makeNewProject(
        ref: ref, selectedLanguage: selectedLanguage);
  }
}
