import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_mobile_flutter/models/enum/message_type.dart';

class MessageModel {
  String? content;
  String? senderId;
  String? messageId;
  MessageType? type;
  Timestamp? time;

  MessageModel(
      {this.content, this.senderId, this.messageId, this.type, this.time});

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderId = json['senderId'];
    messageId = json['messageId'];

    if (json['type'] == 'text') {
      type = MessageType.TEXT;
    } else {
      type = MessageType.IMAGE;
    }

    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['senderId'] = this.senderId;
    data['messageId'] = this.messageId;

    if (this.type == MessageType.TEXT) {
      data['type'] = 'text';
    } else {
      data['type'] = 'image';
    }

    data['time'] = this.time;
    return data;
  }
}
