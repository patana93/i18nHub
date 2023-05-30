import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/context_top_menu/presentation/controller/context_top_menu_controller.dart';
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
            label: "Save",
            onPressed: () => ref
                .read(contextTopMenuControllerProvider.notifier)
                .saveProject("fileName"),
          ),
          MenuEntry(
            label: "Save as JSON",
            onPressed: () => ref
                .read(contextTopMenuControllerProvider.notifier)
                .saveJsonLanguages(),
          ),
          MenuEntry(
            label: "Load",
            onPressed: () => ref
                .read(contextTopMenuControllerProvider.notifier)
                .loadProject(),
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
