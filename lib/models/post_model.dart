class PostModel {
  String creatorName;
  String description;
  String image;
  String creatorImage;
  String id;
  bool isOwner;
  String createdAt;

  PostModel({
    required this.isOwner,
    required this.id,
    required this.creatorName,
    required this.description,
    required this.image,
    required this.creatorImage,
    required this.createdAt,
  });
}