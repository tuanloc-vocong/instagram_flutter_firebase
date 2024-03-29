import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_mobile_flutter/widgets/indicators.dart';

Widget cachedNetworkImage(String imgUrl) {
  return CachedNetworkImage(
    imageUrl: imgUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => circularProgress(context),
    errorWidget: (context, url, error) => Center(
      child: Text(
        'Unable to load image',
        style: TextStyle(fontSize: 10.0),
      ),
    ),
  );
}
