import 'package:flutter/material.dart';
import 'package:i18n_hub/core/utils/colors.dart';

class I18NSnackBar {
  static notImplementedYetSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Not implemented yet'),
    ));
  }

  static displayErrorSnackbar(BuildContext context, {String? errorMessage}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage ?? "Error"),
      backgroundColor: I18nColor.alert,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static displaySuccessSnackbar(BuildContext context,
      {String? successMessage}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
          child: Text(
        successMessage ?? "Success",
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.white),
      )),
      backgroundColor: I18nColor.blue,
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width / 4,
      elevation: 8,
    ));
  }
}
