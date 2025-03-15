import 'package:facedetection/face_detection.dart';
import 'package:facedetection/face_detection_enjection.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Supabase.initialize(
  //   url: 'https://gapjxaxekzslcnsevkik.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdhcGp4YXhla3pzbGNuc2V2a2lrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA4NzU5NTksImV4cCI6MjA1NjQ1MTk1OX0.xGRbwfXGTetm3rwqED3Bw8WpI8k0D3OLzQTT5agq3sI',
  // );
  FaceDetectionEnjection().init();
  runApp(const FaceDetection());
}
