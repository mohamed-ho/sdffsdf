class FaceModel {
  final String name;
  final String imageUrl;

  FaceModel({
    required this.name,
    required this.imageUrl,
  });

  factory FaceModel.fromJson(Map<String, dynamic> json) {
    return FaceModel(
      name: json['name'],
      imageUrl: json['photo_url'],
    );
  }
}
