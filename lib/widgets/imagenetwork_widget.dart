import 'package:flutter/material.dart';
import 'package:mascotas_app/providers/base_provider.dart';


class ImageNetworkWidget extends StatelessWidget {
  final BoxFit fit;
  final String source;
  final String baseUrl;
  final double height;
  final double width;

  const ImageNetworkWidget({
    Key key,
    this.fit = BoxFit.cover,
    @required this.source,
    this.baseUrl,
    this.height,
    this.width,
  }) : super(key: key);

  String _getUrl() {
    if (source.isNotEmpty) {
      return "${baseUrl ?? BaseProvider.mediaURL}$source";
    }

    return "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU";
  }


  @override
  Widget build(BuildContext context) {
    return Image.network(
      _getUrl(),
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
      fit: source.isNotEmpty ? fit : BoxFit.contain,
      height: height ?? null,
      width: width ?? null,
    );
  }
}