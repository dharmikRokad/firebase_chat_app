import 'package:flutter/material.dart';

extension SnackBarExt on BuildContext {
  showSuccess(String msg) {
    final SnackBar snak = SnackBar(
      content: Text(msg),
      showCloseIcon: true,
      backgroundColor: Colors.green,
    );
    return ScaffoldMessenger.of(this).showSnackBar(snak);
  }

  showError(String msg) {
    final SnackBar snak = SnackBar(
      content: Text(msg),
      showCloseIcon: true,
      backgroundColor: Colors.red,
    );
    return ScaffoldMessenger.of(this).showSnackBar(snak);
  }

  showWarning(String msg) {
    final SnackBar snak = SnackBar(
      content: Text(msg),
      showCloseIcon: true,
      backgroundColor: Colors.orange,
    );
    return ScaffoldMessenger.of(this).showSnackBar(snak);
  }
}
