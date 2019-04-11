import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String url;
  final String defaultUrl;
  final double size;
  final bool isCircle;

  CustomAvatar({
    this.url,
    this.defaultUrl: "lib/common/images/user/default-avator.png",
    this.size: 32.0,
    this.isCircle: true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: isCircle
          ? CircleAvatar(
              child: url != null && url.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) => Image.asset(defaultUrl),
                      errorWidget: (context, url, error) => Image.asset(defaultUrl),
                    )
                  : Image.asset(defaultUrl),
            )
          : url != null && url.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) => Image.asset(defaultUrl),
                  errorWidget: (context, url, error) => Image.asset(defaultUrl),
                )
              : Image.asset(defaultUrl),
    );
  }
}
