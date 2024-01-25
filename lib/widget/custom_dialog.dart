import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog {
  static void show(
    BuildContext context,
    String content, {
    String? title,
    String? message,
    void Function()? onPressed,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: GoogleFonts.getFont(
                    'Inter',
                    color: const Color.fromARGB(255, 244, 123, 19),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              : null,
          content: Text(
            content,
            style: GoogleFonts.getFont(
              'Inter',
              color: const Color.fromARGB(255, 244, 123, 19),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          actions: [
            TextButton(
              onPressed: onPressed ??
                  () {
                    Navigator.of(context).pop();
                  },
              child: Text(
                "Đóng",
                style: GoogleFonts.getFont(
                  'Inter',
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(vertical: 0),
        );
      },
    );
  }
}
