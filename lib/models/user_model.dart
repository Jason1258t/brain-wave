class UserModel {
  final String uid;
  final String name;
  final String imageUrl;
  final int lastSeenInMs;
  UserModel({required this.uid, required this.imageUrl, required this.name, required this.lastSeenInMs});
}