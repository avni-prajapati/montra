import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';

class UpdateAlertDialogue extends StatelessWidget {
  const UpdateAlertDialogue({
    super.key,
    required this.isUpdateRequired,
    required this.contextToPop,
  });

  final bool isUpdateRequired;
  final BuildContext contextToPop;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        isUpdateRequired
            ? 'Update is required to continue using the application'
            : 'Update is available. Do you want to update now?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
          child: const Text(
            'Update',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
          ),
        ),
        if (!isUpdateRequired)
          TextButton(
            onPressed: () async {
              Navigator.pop(contextToPop);
              contextToPop.replaceRoute(const BottomNavigationBarRoute());
            },
            child: const Text(
              'later',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          )
      ],
    );
  }
}
