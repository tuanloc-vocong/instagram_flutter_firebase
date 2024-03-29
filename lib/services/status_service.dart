import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_mobile_flutter/models/status.dart';

class StatusService {
  void showSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  sendStatus(StatusModel status, String chatId) {}
  sendFirstStatus(StatusModel status) {}
  uploadImage(File image) {}
}
