import 'package:facedetection/core/constant/app_colors.dart';
import 'package:facedetection/models/face_model.dart';
import 'package:facedetection/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SuccessLoginScreen extends StatelessWidget {
  const SuccessLoginScreen({super.key, required this.face});
  final FaceModel face;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false),
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        title: Text(
          'User Data',
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.4,
              backgroundImage: NetworkImage(face.imageUrl),
              backgroundColor: AppColors.secondColor,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Welcome ${face.name}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
