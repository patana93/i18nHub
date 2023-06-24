import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/core/utils/colors.dart';
import 'package:i18n_hub/features/manage_language/presentation/widget/add_language_dialog.dart';

class AddLanguageActionChip extends ConsumerWidget {
  const AddLanguageActionChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      elevation: 8.0,
      padding: const EdgeInsets.all(2.0),
      avatar: const Icon(
        Icons.add,
        size: 30,
        color: Color(0xFFFEF9FF),
      ),
      label: SizedBox(
        height: 40,
        width: 160,
        child: Center(
          child: Text(
            'Add Language',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                // ignore: prefer_const_constructors
                .copyWith(color: Color(0xFFFEF9FF), fontSize: 18),
          ),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AddLanaguageDialog();
          },
        );
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: I18nColor.blue,
      shadowColor: I18nColor.blue.withOpacity(0.7),
    );
  }
}
