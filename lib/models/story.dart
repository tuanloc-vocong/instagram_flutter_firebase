class StoryModel {
  final String id;
  final String username;
  final List<String>? description;
  final List<String> photoUrl;
  final DateTime createdAt;
  final String profilePicture;
  final String statusId;
  final List<String> whoCanSee;

  StoryModel(
      {required this.id,
      required this.username,
      required this.photoUrl,
      this.description,
      required this.createdAt,
      required this.profilePicture,
      required this.statusId,
      required this.whoCanSee});

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
        id: map['id'] ?? '',
        username: map['username'] ?? '',
        photoUrl: List<String>.from(map['photoUrl']),
        createdAt: map['createdAt'],
        profilePicture: map['profilePicture'],
        statusId: map['statusId'],
        whoCanSee: List<String>.from(map['whoCanSee']));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'description': description,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'profilePicture': profilePicture,
      'statusId': statusId,
      'whoCanSee': whoCanSee,
    };
  }
}
