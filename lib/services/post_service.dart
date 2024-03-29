import 'dart:io';

import 'package:instagram_mobile_flutter/models/user.dart';

class PostService {
  uploadProfilePicture(File image, UserModel user) {}
  uploadPost(File image, String location, String description) {}
  uploadComment(String currentUderId, String comment, String postId,
      String ownerId, String mediaUrl) {}
  addCommentToNotification(
      String type,
      String commentData,
      String username,
      String userId,
      String postId,
      String mediaUrl,
      String ownerId,
      String userDp) {}
  addLikesToNotification(String type, String username, String userId,
      String postId, String mediaUrl, String ownerId, String uerDp) {}
  removeLikeFromNotification(
      String ownerId, String postId, String currentUser) {}
}
