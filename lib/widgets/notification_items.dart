import 'dart:js_interop_unsafe';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_mobile_flutter/models/notification.dart';
import 'package:instagram_mobile_flutter/widgets/indicators.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationItems extends StatefulWidget {
  final NotificationModel? notification;

  NotificationItems({this.notification});

  @override
  _NotificationItemsState createState() => _NotificationItemsState();
}

class _NotificationItemsState extends State<NotificationItems>{
  @override
  Widget build(BuildContext context){
    return Dismissible(
      key: ObjectKey("${widget.notification}"),
      background: stackBehindDismiss(),
      direction: DismissDirection.endToStart,
      onDismissed: (v){delete();},
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        onTap: (){
      Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => widget.notification!.type == "follow" ? Profile(profileId: widget.notification!.userId) : VIewNotificationDetails(notification: widget.notification!),),
      ),
    },
    leading: widget.notification!.userDp!.isEmpty ? CircleAvatar(
      radius: 20.0,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Center(child: Text('${widget.notification!.username![0].toUpperCase()}', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold,),),),
    ) : CircleAvatar(radius: 20.0, backgroundImage: CachedNetworkImageProvider('${widget.notification!.userDp!}',),),title: RichText(overflow: TextOverflow.ellipsis,text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 14.0,), children: [
      TextSpan(
        text: '${widget.notification!.username!}',
        style: TextStyle(fontSize: 14.0, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
      ),
      TextSpan(
        text: buildTextConfiguration(),
        style: TextStyle(
          fontSize: 12.0,
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        )
      )
    ]),), subtitle: Text(timeago.format(widget.notification!.dateTime!)),trailing: previewConfiguration(),));
  }

  Widget stackBehindDismiss(){
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Theme.of(context).colorScheme.secondary,
      child: Icon(
        CupertinoIcons.delete,
        color: Colors.white,
      ),
    );
  }

  delete(){}

  previewConfiguration(){
    if(widget.notification!.type == "like" || widget.notification!.type == "comment"){
      return buildPreviewImage();
    }else{
      return Text('');
    }
  }

  buildTextConfiguration(){
    if(widget.notification!.type == "like"){
      return "liked your post";
    }else if(widget.notification!.type == "follow"){
      return "is following you";
    }else if(widget.notification!.type == "comment"){
      return "commented '${widget.notification!.type}'";
    }else{
      return "Error: Unknown type '${widget.notification!.type}'";
    }
  }

  buildPreviewImage(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: CachedNetworkImage(imageUrl: widget.notification!.mediaUrl!, placeholder: (context, url){
        return circularProgress(context);
      }, errorWidget: (context, url, error){
        return Icon(Icons.error);
      },
      height: 40.0,
      fit: BoxFit.cover,
      width: 40.0,),
    );
  }
}
