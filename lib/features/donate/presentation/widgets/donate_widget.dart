import 'package:flutter/material.dart';
import 'package:i18n_hub/core/widget/snackbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateWidget extends StatelessWidget {
  const DonateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        label: const Text("Donate with PayPal"),
        icon: const Icon(Icons.paypal),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600]),
        onPressed: () async {
          if (!await launchUrl(Uri.parse(
              "https://www.paypal.com/donate?hosted_button_id=H4VDUNJN72ZSS"))) {
          } else {
            if (context.mounted) {
              I18NSnackBar.displayErrorSnackbar(context,
                  errorMessage: "Cannot open the link");
            }
          }
        });
  }
}
