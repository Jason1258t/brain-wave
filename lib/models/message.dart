class Message{
  String authorName;
  String authorImage;
  String text;
  bool isReverse;
  bool isLoad;
  String createdAt;

  Message({required this.isReverse, required this.text, required this.isLoad, required this.authorName, required this.authorImage, required this.createdAt});
}