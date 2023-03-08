import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_language/presentation/widget/add_language_dialog.dart';

class AddLanguageActionChip extends ConsumerWidget {
  const AddLanguageActionChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      elevation: 8.0,
      padding: const EdgeInsets.all(2.0),
      avatar: const Icon(
        Icons.add,
        color: Colors.blue,
        size: 20,
      ),
      label: const Text('Add Language'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AddLanaguageDialog();
          },
        );
      },
      backgroundColor: Colors.grey[200],
    );
  }
}
