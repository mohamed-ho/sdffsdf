import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:facedetection/models/face_model.dart';
import 'package:facedetection/service/google_ml_kit.dart';
import 'package:facedetection/service/supabase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  final SupabaseService supabaseService;
  final GoogleMlKitService googleMlKitService;
  DetectionCubit(
      {required this.supabaseService, required this.googleMlKitService})
      : super(DetectionInitial());

  Future<void> register({required String name, required File image}) async {
    emit(DetecationLoadingSate());
    final reuslt = await supabaseService.uploadImage(name, image);
    reuslt.fold((l) => emit(DetectionErrorState(message: l.message)),
        (r) => emit(DetecationLoadedSate()));
  }

  Future<void> login({required File image}) async {
    emit(DetecationLoadingSate());
    final reuslt = await googleMlKitService.compareFaces(image);
    reuslt.fold((l) => emit(DetectionErrorState(message: l.message)),
        (r) => emit(DetectionLoginedState(face: r)));
  }
}
