import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'word_item_key_validator_controller.g.dart';

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
    if (value.contains(" ")) {
      state = "Key cannot contain any space";
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
