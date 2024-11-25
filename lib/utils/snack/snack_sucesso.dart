import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void snackSucesso(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 20, 
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: AwesomeSnackbarContent(
          title: 'Sucesso!',
          message: message,
          contentType: ContentType.success,
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
