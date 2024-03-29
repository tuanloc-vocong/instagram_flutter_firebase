import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_mobile_flutter/components/chat_item.dart';
import 'package:instagram_mobile_flutter/models/message.dart';
import 'package:instagram_mobile_flutter/utils/firebase.dart';
import 'package:instagram_mobile_flutter/view_models/user/user_view_model.dart';
import 'package:instagram_mobile_flutter/widgets/indicators.dart';
import 'package:provider/provider.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel =
        Provider.of<UserViewModel>(context, listen: false);
    viewModel.setUser();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
        title: Text('Chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userChatsStream('${viewModel.user!.uid ?? ""}'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List chatList = snapshot.data!.docs;
            if (chatList.isNotEmpty) {
              return ListView.separated(
                itemCount: chatList.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot chatListSnapshot = chatList[index];
                  return StreamBuilder<QuerySnapshot>(
                    stream: messageListStream(chatListSnapshot.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List messages = snapshot.data!.docs;
                        MessageModel message = MessageModel.fromJson(
                          messages.first.data(),
                        );
                        List users = chatListSnapshot.get('users');
                        users.remove('${viewModel.user!.uid ?? ""}');
                        String recipient = users[0];
                        return ChatItem(
                            userId: recipient,
                            time: message.dateTime!,
                            message: message.content!,
                            messageCount: messages.length,
                            chatId: chatListSnapshot.id,
                            type: message.type!,
                            currentUderId: viewModel.user!.uid ?? "");
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Divider(),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No Chats'));
            }
          } else {
            return Center(child: circularProgress(context));
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot> userChatsStream(String uid) {
    return chatRef
        .where('users', arrayContains: '$uid')
        .orderBy('lastTextTime', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> messageListStream(String documentId) {
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
