import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_mobile_flutter/models/enum/message_type.dart';
import 'package:instagram_mobile_flutter/models/message.dart';
import 'package:instagram_mobile_flutter/models/user.dart';
import 'package:instagram_mobile_flutter/utils/firebase.dart';
import 'package:instagram_mobile_flutter/view_models/conversation/conversation_view_model.dart';

class Conversation extends StatefulWidget {
  final String userId;
  final String chatId;

  const Conversation({required this.userId, required this.chatId});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  bool isFirst = false;
  String? chatId;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  builderUserName() {
    return StreamBuilder(
      stream: usersRef.doc('${widget.userId}').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot documentSnapshot =
              snapshot.data as DocumentSnapshot<Object?>;
          UserModel user = UserModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          return InkWell(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Hero(
                    tag: user.email!,
                    child: user.photoUrl!.isEmpty
                        ? CircleAvatar(
                            radius: 25.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Center(
                              child: Text(
                                '${user.username![0].toUpperCase()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 25.0,
                            backgroundImage:
                                CachedNetworkImageProvider('${user.photoUrl}'),
                          ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(child: Column())
              ],
            ),
          );
        }
      },
    );
  }

  showPhotoOptions(ConversationViewModel viewModel, var user) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Camera"),
                onTap: () {
                  sendMessage(viewModel, user, imageType: 0, isImage: true);
                },
              ),
              ListTile(
                title: Text("Gallery"),
                onTap: () {
                  sendMessage(viewModel, user, imageType: 1, isImage: true);
                },
              )
            ],
          );
        });
  }

  sendMessage(ConversationViewModel viewModel, var user,
      {bool isImage = false, int? imageType}) async {
    String msg;
    if (isImage) {
      msg = await viewModel.pickImage(
          source: imageType!, context: context, chatId: widget.chatId);
    } else {
      msg = messageController.text.trim();
      messageController.clear();
    }

    MessageModel message = MessageModel(
        content: '$msg',
        senderId: user?.uid,
        type: isImage ? MessageType.IMAGE : MessageType.TEXT,
        time: Timestamp.now());

    if (msg.isNotEmpty) {
      if (isFirst) {
        print("FIRST");
        String id = await viewModel.sendFirstMessage(widget.userId, message);
        setState(() {
          isFirst = false;
          chatId = id;
          chatIdRef.add({
            "users": getUser(firebaseAuth.currentUser!.uid, widget.userId),
            "chatId": id
          });
          viewModel.sendMessage(widget.chatId, message);
        });
      } else {
        viewModel.sendMessage(widget.chatId, message);
      }
    }
  }

  String getUser(String user1, String user2) {
    user1 = user1.substring(0, 5);
    user2 = user2.substring(0, 5);
    List<String> list = [user1, user2];
    list.sort();
    var chatId = "${list[0]}-${list[1]}";
    return chatId;
  }

  Stream<QuerySnapshot> messageListStream(String documentId) {
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }
}
