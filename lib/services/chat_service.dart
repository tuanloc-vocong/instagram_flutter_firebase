import 'dart:io';

import 'package:instagram_mobile_flutter/models/message.dart';
import 'package:instagram_mobile_flutter/models/user.dart';

class ChatService {
  sendMessage(MessageModel message, String chatId) {}
  sendFirstMessage(MessageModel message, String recipient) async {}
  uploadImage(File image, String chatId) {}
  setUserRead(String chatId, UserModel user, int count) async {}
  setUserTyping(String chatId, UserModel user, bool userTyping) async {}
}
