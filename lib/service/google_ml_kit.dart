// import 'dart:io';

// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'google_mlkit_face_detection';

// class GoogleMlKitService {
// Future<List<Face>> detectFaces(File imageFile) async {
//   final inputImage = InputImage.fromFile(imageFile);
//   final faceDetector =GoogleMlKit.vision.faceDetector (
//     FaceDetectorOptions(enableContours: true),
//   );
//   final faces = await faceDetector.processImage(inputImage);
//   return faces;
// }

// }

import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:facedetection/core/failure/failure.dart';
import 'package:facedetection/models/face_model.dart';
import 'package:facedetection/service/supabase_service.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleMlKitService {
  Future<List<Face>> detectFaces(File imageFile) async {
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFile(imageFile);
    final faces = await faceDetector.processImage(inputImage);
    return faces;
  }

  Future<Either<Failure, FaceModel>> compareFaces(File newFaceImage) async {
    try {
      List<FaceModel> storedFaces =
          await SupabaseService(supabase: Supabase.instance).fetchStoredFaces();
      List<Face> newFaceData = await detectFaces(newFaceImage);

      for (var faceData in storedFaces) {
        File storedFaceFile = await SupabaseService(supabase: Supabase.instance)
            .downloadImage(faceData.imageUrl.split('/').last);
        List<Face> storedFaceData = await detectFaces(storedFaceFile);
        if (newFaceData.isNotEmpty && storedFaceData.isNotEmpty) {
          log('this is lenght of new face data ${newFaceData.length}');
          log('this is lenght of new face stored face  ${storedFaceData.length}');
          if (_compareFaceData(newFaceData.first, storedFaceData.first)) {
            log('this is iamge is match');
            return Right(faceData);
          }
        }
      }
      throw Exception('this iamge is not match');
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  bool _compareFaceData(Face newFace, Face storedFace) {
    // مقارنة النقاط الأساسية مثل العينين والفم والأنف
    double dx = (newFace.boundingBox.left - storedFace.boundingBox.left).abs();
    double dy = (newFace.boundingBox.top - storedFace.boundingBox.top).abs();
    log('dx is $dx dy is $dy');
    return dx < 150 && dy < 150; // السماح بفارق بسيط
  }
}
