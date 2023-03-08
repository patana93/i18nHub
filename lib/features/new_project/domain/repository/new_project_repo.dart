import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_project_repo.g.dart';

abstract class NewProjectRepository {
  void makeNewProject({required Ref ref, required String selectedLanguage});
}

class NewProjectRepositoryImpl implements NewProjectRepository {
  NewProjectRepositoryImpl();

  @override
  void makeNewProject({required Ref ref, required selectedLanguage}) {
    ref.read(manageWordItemControllerProvider.notifier).clearAll();
    /*    ref
        .read(manageWordItemControllerProvider.notifier)
        .addTranslation(newLanguage: selectedLanguage); */
  }
}

@riverpod
NewProjectRepositoryImpl makeNewProjectRepository(
        MakeNewProjectRepositoryRef ref) =>
    NewProjectRepositoryImpl();
