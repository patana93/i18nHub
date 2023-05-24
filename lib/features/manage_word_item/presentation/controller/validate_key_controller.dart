import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'validate_key_controller.g.dart';

@riverpod
class ValidateKeyController extends _$ValidateKeyController {
  @override
  String? build() {
    return "";
  }

  validate(String? value) {
    if (value == null || value.isEmpty) {
      state = "Enter a valid key";
      return;
    }
    if (value.startsWith(RegExp(r'[1-9]'))) {
      state = "Key cannot start with a number";
      return;
    }
    if (value.startsWith("_")) {
      state = "Key cannot start with an underscore";
      return;
    }
    if (value.contains(RegExp(r'[^\w-]'))) {
      state = "Key cannot contain special characters or space";
      return;
    }
    if (ref
        .read(manageWordItemControllerProvider.notifier)
        .checkWordItemKeyAlreadyExist(key: value)) {
      state = "Key already used";
      return;
    }
    state = null;
  }
}
