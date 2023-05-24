import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/new_project/presentation/widget/file_menu/load.dart';
import 'package:i18n_app/features/new_project/presentation/widget/file_menu/new_project.dart';
import 'package:i18n_app/features/new_project/presentation/widget/file_menu/save.dart';
import 'package:i18n_app/features/new_project/presentation/widget/file_menu/save_as_json.dart';
import 'package:i18n_app/features/new_project/presentation/widget/menu_entry.dart';
import 'package:i18n_app/features/new_project/presentation/widget/settings_menu/select_save_path.dart';

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
          getSaveMenu(ref),
          getSaveAsJsonMenu(ref),
          getLoadMenu(ref),
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
