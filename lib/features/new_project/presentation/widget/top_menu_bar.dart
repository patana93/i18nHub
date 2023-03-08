import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuEntry {
  const MenuEntry(
      {required this.label, this.shortcut, this.onPressed, this.menuChildren})
      : assert(menuChildren == null || onPressed == null,
            'onPressed is ignored if menuChildren are provided');
  final String label;

  final MenuSerializableShortcut? shortcut;
  final VoidCallback? onPressed;
  final List<MenuEntry>? menuChildren;

  static List<Widget> build(List<MenuEntry> selections) {
    Widget buildSelection(MenuEntry selection) {
      if (selection.menuChildren != null) {
        return SubmenuButton(
          menuChildren: MenuEntry.build(selection.menuChildren!),
          child: Text(selection.label),
        );
      }
      return MenuItemButton(
        shortcut: selection.shortcut,
        onPressed: selection.onPressed,
        child: Text(selection.label),
      );
    }

    return selections.map<Widget>(buildSelection).toList();
  }

  static Map<MenuSerializableShortcut, Intent> shortcuts(
      List<MenuEntry> selections) {
    final Map<MenuSerializableShortcut, Intent> result =
        <MenuSerializableShortcut, Intent>{};
    for (final MenuEntry selection in selections) {
      if (selection.menuChildren != null) {
        result.addAll(MenuEntry.shortcuts(selection.menuChildren!));
      } else {
        if (selection.shortcut != null && selection.onPressed != null) {
          result[selection.shortcut!] =
              VoidCallbackIntent(selection.onPressed!);
        }
      }
    }
    return result;
  }
}

class TopMenuBar extends StatelessWidget {
  const TopMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: MenuBar(
                children: MenuEntry.build(_getMenus()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<MenuEntry> _getMenus() {
    final List<MenuEntry> result = <MenuEntry>[
      MenuEntry(
        label: 'Menu Demo',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: 'About',
            onPressed: () {},
          ),
          MenuEntry(
            label: 'Hide Message',
            onPressed: () {},
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyS, control: true),
          ),
          // Hides the message, but is only enabled if the message isn't
          // already hidden.
          const MenuEntry(
            label: 'Reset Message',
            onPressed: null,
            shortcut: SingleActivator(LogicalKeyboardKey.escape),
          ),
          MenuEntry(
            label: 'Background Color',
            menuChildren: <MenuEntry>[
              MenuEntry(
                label: 'Red Background',
                onPressed: () {},
                shortcut: const SingleActivator(LogicalKeyboardKey.keyR,
                    control: true),
              ),
              MenuEntry(
                label: 'Green Background',
                onPressed: () {},
                shortcut: const SingleActivator(LogicalKeyboardKey.keyG,
                    control: true),
              ),
              MenuEntry(
                label: 'Blue Background',
                onPressed: () {},
                shortcut: const SingleActivator(LogicalKeyboardKey.keyB,
                    control: true),
              ),
            ],
          ),
        ],
      ),
      MenuEntry(
        label: 'Menu Demo',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: 'About',
            onPressed: () {},
          ),
          MenuEntry(
            label: 'Hide Message',
            onPressed: () {},
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyS, control: true),
          ),
          // Hides the message, but is only enabled if the message isn't
          // already hidden.
          const MenuEntry(
            label: 'Reset Message',
            onPressed: null,
            shortcut: SingleActivator(LogicalKeyboardKey.escape),
          ),
          MenuEntry(
            label: 'Background Color',
            menuChildren: <MenuEntry>[
              MenuEntry(
                label: 'Red Background',
                onPressed: () {},
                shortcut: const SingleActivator(LogicalKeyboardKey.keyR,
                    control: true),
              ),
              MenuEntry(
                label: 'Green Background',
                onPressed: () {},
                shortcut: const SingleActivator(LogicalKeyboardKey.keyG,
                    control: true),
              ),
              MenuEntry(
                label: 'Blue Background',
                onPressed: () {},
                shortcut: const SingleActivator(LogicalKeyboardKey.keyB,
                    control: true),
              ),
            ],
          ),
        ],
      ),
    ];
    // (Re-)register the shortcuts with the ShortcutRegistry so that they are
    // available to the entire application, and update them if they've changed.
    //_shortcutsEntry?.dispose();
    //_shortcutsEntry =
    //    ShortcutRegistry.of(context).addAll(MenuEntry.shortcuts(result));
    return result;
  }
}
