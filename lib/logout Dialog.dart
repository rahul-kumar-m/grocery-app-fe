import "package:flutter/material.dart";

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Do you want to Logout?'),
      content: Text('press cancel if you dont want to otherwise press yes'),
      actions: [
        TextButton(
          onPressed: () {
            // Close the AlertDialog when the "OK" button is pressed
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Close the AlertDialog when the "OK" button is pressed
            Navigator.of(context).pop();
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
