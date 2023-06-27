import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/core/widget/snackbar_widget.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/controller/context_top_menu_controller.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/widget/file_menu/load_from_json_wizard.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/widget/file_menu/new_project.dart';
import 'package:i18n_hub/features/context_top_menu/domain/model/menu_entry.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/widget/file_menu/save_project.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/widget/settings_menu/select_save_path.dart';

class TopMenuBar extends ConsumerWidget {
  const TopMenuBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: MenuBar(
                children: MenuEntry.build(_getMenus(context, ref)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //TODO Improve snackbar (add also error case)
  List<MenuEntry> _getMenus(BuildContext context, WidgetRef ref) {
    final List<MenuEntry> result = <MenuEntry>[
      MenuEntry(
        label: 'File',
        menuChildren: <MenuEntry>[
          getNewProjectMenu(context, ref),
          MenuEntry(
              label: "Save Project",
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => const SaveProjectDialog());
                if (context.mounted) {
                  I18NSnackBar.displaySuccessSnackbar(context,
                      successMessage: "Project saved");
                }
              }),
          MenuEntry(
              label: "Save as JSONs",
              onPressed: () {
                ref
                    .read(contextTopMenuControllerProvider.notifier)
                    .saveJsonLanguages(isWithNodes: false);

                I18NSnackBar.displaySuccessSnackbar(context,
                    successMessage: "JSONs created");
              }),
          MenuEntry(
            label: "Save as JSONs with nodes",
            onPressed: () {
              ref
                  .read(contextTopMenuControllerProvider.notifier)
                  .saveJsonLanguages(isWithNodes: true);

              I18NSnackBar.displaySuccessSnackbar(context,
                  successMessage: "JSONs with node created");
            },
          ),
          MenuEntry(
            label: "Load project",
            onPressed: () async {
              await ref
                  .read(contextTopMenuControllerProvider.notifier)
                  .loadProject(context)
                  .whenComplete(() => I18NSnackBar.displaySuccessSnackbar(
                      context,
                      successMessage: "Project loaded"));
            },
          ),
          MenuEntry(
              label: "Load from JSONs",
              onPressed: () async {
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => ProviderScope(
                      parent: ProviderScope.containerOf(context),
                      child: const LoadFromJsonWizard()),
                );
                if (context.mounted) {
                  I18NSnackBar.displaySuccessSnackbar(context,
                      successMessage: "JSONs loaded");
                }
              })
        ],
      ),
      MenuEntry(
        label: 'Settings',
        menuChildren: <MenuEntry>[
          getSelecteSavePathMenu(context),
        ],
      ),
      MenuEntry(
        label: 'Help',
        menuChildren: <MenuEntry>[
          getSelecteSavePathMenu(context),
        ],
      ),
    ];
    return result;
  }
}
