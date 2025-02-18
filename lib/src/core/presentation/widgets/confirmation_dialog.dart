import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.content,
    required this.confirmText,
    this.title = "Alert!",
    this.cancelText = "Cancel",
    this.onCancel,
    this.onSubmit,
  });

  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            context.pop();
          },
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () async {
            onSubmit?.call();
            context.pop();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}
