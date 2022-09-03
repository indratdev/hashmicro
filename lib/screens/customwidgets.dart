import 'package:flutter/material.dart';

class CustomWidgets {
  static showWarningDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Image.asset(
              "assets/images/warning.png",
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  static showSuccesFailedDialog(
      BuildContext context, String content, bool isSuccess) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: (isSuccess)
                ? Image.asset(
                    "assets/images/checked.png",
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 8,
                  )
                : Image.asset(
                    "assets/images/cancel.png",
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 8,
                  ),
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }
}
