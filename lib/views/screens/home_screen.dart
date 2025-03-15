import 'package:facedetection/core/constant/app_colors.dart';
import 'package:facedetection/views/screens/login_face_screen.dart';
import 'package:facedetection/views/screens/register_face_screen.dart';
import 'package:facedetection/views/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          title: Text(
            'Face Detection',
          ),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/face_detection.png'),
            CustomElevatedButton(
              buttonText: "Login",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginFaceScreen())),
            ),
            CustomElevatedButton(
              buttonText: "Register",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterFaceScreen())),
            ),
          ],
        ));
  }
}
