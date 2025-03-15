import 'package:facedetection/views/screens/home_screen.dart';

import 'package:flutter/material.dart';

class FaceDetection extends StatelessWidget {
  const FaceDetection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
