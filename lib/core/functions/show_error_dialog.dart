import 'package:facedetection/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

Future<dynamic> showErrorDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: AppColors.secondColor,
            title: Text(
              'Error',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            content: Text(message, style: TextStyle(color: Colors.white)),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  child: const Text('OK'))
            ],
          ));
}
