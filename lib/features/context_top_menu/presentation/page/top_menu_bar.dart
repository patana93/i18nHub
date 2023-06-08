import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/context_top_menu/presentation/controller/context_top_menu_controller.dart';
import 'package:i18n_app/features/context_top_menu/presentation/widget/file_menu/load_from_json_wizard.dart';
import 'package:i18n_app/features/context_top_menu/presentation/widget/file_menu/new_project.dart';
import 'package:i18n_app/features/context_top_menu/domain/model/menu_entry.dart';
import 'package:i18n_app/features/context_top_menu/presentation/widget/settings_menu/select_save_path.dart';

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

  List<MenuEntry> _getMenus(BuildContext context, WidgetRef ref) {
    final List<MenuEntry> result = <MenuEntry>[
      MenuEntry(
        label: 'File',
        menuChildren: <MenuEntry>[
          getNewProjectMenu(context, ref),
          MenuEntry(
              label: "Save Project",
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();
                    final formKey = GlobalKey<FormState>();
                    return AlertDialog(
                      title: const Text("File name"),
                      content: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: controller,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "File name cannot be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() == true) {
                                ref
                                    .read(contextTopMenuControllerProvider
                                        .notifier)
                                    .saveProject(controller.text);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text("Confirm")),
                      ],
                    );
                  })),
          MenuEntry(
            label: "Save as JSONs",
            onPressed: () => ref
                .read(contextTopMenuControllerProvider.notifier)
                .saveJsonLanguages(isWithNodes: false),
          ),
          MenuEntry(
            label: "Save as JSONs with nodes",
            onPressed: () => ref
                .read(contextTopMenuControllerProvider.notifier)
                .saveJsonLanguages(isWithNodes: true),
          ),
          MenuEntry(
            label: "Load project",
            onPressed: () => ref
                .read(contextTopMenuControllerProvider.notifier)
                .loadProject(),
          ),
          MenuEntry(
            label: "Load from JSONs",
            onPressed: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ProviderScope(
                  parent: ProviderScope.containerOf(context),
                  child: const LoadFromJsonWizard()),
            ),
          )
        ],
      ),
      MenuEntry(
        label: 'Settings',
        menuChildren: <MenuEntry>[
          getSelecteSavePathMenu(context),
        ],
      ),
    ];
    return result;
  }
}
