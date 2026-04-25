import 'package:flutter/material.dart';

class Uihelper {
  static void showloaderdialog(BuildContext context) {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (builder) {
    //     return const AppLoadingWidget(size: 50);
    //   },
    // );
  }

  static void hideloader(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
  }

  static void showDialogPrompt(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (builder) {
        return Container(child: Text(msg));
      },
    );
  }
}
