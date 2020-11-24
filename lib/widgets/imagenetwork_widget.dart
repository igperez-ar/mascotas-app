import 'package:flutter/material.dart';


class ImageNetworkWidget extends StatelessWidget {
  final BoxFit fit;
  final String source;

  const ImageNetworkWidget({
    Key key,
    this.fit = BoxFit.cover,
    @required this.source,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Image.network(
      source/* 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU' */,
      filterQuality: FilterQuality.low,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
        if (loadingProgress == null)
          return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
              : null,
          ),
        );
      },
      fit: /* widget.establecimiento.foto != null ?  */fit/*  : BoxFit.contain */
    );
  }
}