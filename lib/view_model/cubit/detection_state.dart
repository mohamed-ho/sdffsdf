part of 'detection_cubit.dart';

abstract class DetectionState extends Equatable {
  const DetectionState();

  @override
  List<Object> get props => [];
}

class DetectionInitial extends DetectionState {}

class DetecationLoadingSate extends DetectionState {}

class DetecationLoadedSate extends DetectionState {}

class DetectionErrorState extends DetectionState {
  final String message;
  const DetectionErrorState({required this.message});
}

class DetectionLoginedState extends DetectionState {
  final FaceModel face;
  const DetectionLoginedState({required this.face});
}
