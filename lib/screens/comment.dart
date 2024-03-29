import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_mobile_flutter/models/post.dart';
import 'package:instagram_mobile_flutter/models/user.dart';
import 'package:instagram_mobile_flutter/services/post_service.dart';

class Comments extends StatefulWidget {
  final PostModel? post;

  Comments({this.post});

  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  UserModel? user;
  PostService services = PostService();
  final DateTime time = DateTime.now();
  TextEditingController commentsTEC = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      leading: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(
          CupertinoIcons.xmark_circle_fill,
        ),
      ),
      centerTitle: true,
      title: Text('Comments'),
    ),body: Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [Flexible(
          child: ListView(
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),child: builFullPost(),)
            ],
          ),
        )],
      ),
    ),)
  }

  
}
