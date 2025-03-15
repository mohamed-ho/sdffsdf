import 'package:facedetection/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.label});
  final IconData icon;
  final Function() onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.secondColor,
          ),
          padding: EdgeInsets.all(10),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
