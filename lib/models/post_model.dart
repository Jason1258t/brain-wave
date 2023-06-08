class PostModel {
  String title;
  String creatorName;
  String description;
  String image;
  String creatorImage;
  String id;
  bool isOwner;

  PostModel({
    required this.isOwner,
    required this.id,
    required this.creatorName,
    required this.title,
    required this.description,
    required this.image,
    required this.creatorImage,
  });
}