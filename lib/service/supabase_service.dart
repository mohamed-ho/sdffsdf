import 'dart:io';
import 'dart:typed_data';
import 'package:facedetection/models/face_model.dart';
import 'package:dartz/dartz.dart';
import 'package:facedetection/core/failure/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final Supabase supabase;
  SupabaseService({required this.supabase});
  Future<Either<Failure, void>> uploadImage(String name, File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          image.path.split('/').last;

      await supabase.client.storage.from('faces').upload(fileName, image);

      final imageUrl =
          supabase.client.storage.from('faces').getPublicUrl(fileName);

      // حفظ بيانات الوجه في Supabase Database
      await supabase.client.from('faces').insert({
        'name': name,
        'photo_url': imageUrl,
      });
      return Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<List<FaceModel>> fetchStoredFaces() async {
    List<Map<String, dynamic>> response =
        await Supabase.instance.client.from('faces').select();

    return List<FaceModel>.from(response.map((e) => FaceModel.fromJson(e)));
  }

  Future<File> downloadImage(String imageName) async {
    try {
      final Uint8List file =
          await supabase.client.storage.from('faces').download(imageName);

      return await uint8ListToTempFile(
          file); // File.fromUri(Uri.parse(imageName));
    } catch (e) {
      rethrow;
    }
  }

  Future<File> uint8ListToTempFile(Uint8List uint8List) async {
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/temp_image.jpg');
    await file.writeAsBytes(uint8List);
    return file;
  }
}
