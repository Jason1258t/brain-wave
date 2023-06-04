class PostModel {
  String title;
  String creatorName;
  String description;
  String image;
  String creatorImage;

  PostModel({
    required this.creatorName,
    required this.title,
    required this.description,
    required this.image,
    required this.creatorImage,
  });
}