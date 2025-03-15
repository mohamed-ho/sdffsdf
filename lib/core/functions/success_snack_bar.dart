import 'package:facedetection/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.secondColor,
    ),
  );
}
