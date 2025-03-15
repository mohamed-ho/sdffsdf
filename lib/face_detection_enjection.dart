import 'package:facedetection/service/google_ml_kit.dart';
import 'package:facedetection/service/supabase_service.dart';
import 'package:facedetection/view_model/cubit/detection_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ls = GetIt.instance;

class FaceDetectionEnjection {
  init() {
    ls.registerFactory(
        () => DetectionCubit(supabaseService: ls(), googleMlKitService: ls()));

    ls.registerLazySingleton(() => SupabaseService(supabase: ls()));
    ls.registerLazySingleton(() => GoogleMlKitService());

    ls.registerLazySingleton(() => Supabase.instance);
  }
}
