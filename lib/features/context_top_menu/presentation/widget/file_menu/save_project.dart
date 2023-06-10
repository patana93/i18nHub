import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/context_top_menu/presentation/controller/context_top_menu_controller.dart';

class SaveProjectDialog extends StatelessWidget {
  const SaveProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
        Consumer(builder: (context, ref, child) {
          return ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  ref
                      .read(contextTopMenuControllerProvider.notifier)
                      .saveProject(controller.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Confirm"));
        }),
      ],
    );
  }
}
