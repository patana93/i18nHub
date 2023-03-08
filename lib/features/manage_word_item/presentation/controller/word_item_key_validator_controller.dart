import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'word_item_key_validator_controller.g.dart';

@riverpod
class ValidateKeyController extends _$ValidateKeyController {
  @override
  String? build() {
    return null;
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a valid key";
    }
    if (value.contains(" ")) {
      return "Key cannot contain any space";
    }
    if (ref
        .read(manageWordItemControllerProvider.notifier)
        .checkWordItemKeyAlreadyExist(key: value)) {
      return "Key already used";
    }
    return null;
  }
}
