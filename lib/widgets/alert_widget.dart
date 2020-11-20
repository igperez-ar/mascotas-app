import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlertWidget extends StatefulWidget {

  final bool compact;

  const AlertWidget({
    Key key,
    this.compact = false
  }) : super(key: key); 

  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {

  Widget _buildCompact() {
    return Container(
      width: widget.compact ? 250 : null,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(1,1)
          )
        ]
      ),
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/id/1005/200/200'))
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Alejandro Alvarez",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.yellow[600]),
                  color: Colors.yellow[600].withOpacity(0.25),
                ),
                child: Text('Perdido', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[800]
                  ) 
                ),
              ),
              Text("1 hora",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Text('that famous sing mind fact equally total thirty far beside mouth deal wild occasionally everybody drop simply worker rocket doing control please impossible road',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              height: 1.5
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: /* Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child:  */Row(
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://source.unsplash.com/UtrE5DcgEyg/700x600'  /* 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU' */,
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
                          fit: /* widget.establecimiento.foto != null ?  */BoxFit.cover/*  : BoxFit.contain */
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              'https://source.unsplash.com/UtrE5DcgEyg/700x500'  /* 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU' */,
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
                              fit: /* widget.establecimiento.foto != null ?  */BoxFit.cover/*  : BoxFit.contain */
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Image.network(
                              'https://source.unsplash.com/UtrE5DcgEyg/700x500'  /* 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU' */,
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
                              fit: /* widget.establecimiento.foto != null ?  */BoxFit.cover/*  : BoxFit.contain */
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              /* ],
            ),
          ), */
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
              Padding(padding: EdgeInsets.only(left:5)),
              Text(
                'Cargando...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600]
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    if (widget.compact) {
      return _buildCompact();
    }

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/id/1005/200/200'))
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Alejandro Alvarez",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 20,),
                          SizedBox(width: 2),
                          Text("San Martín 154",
                            style: TextStyle(
                              color: Colors.grey[600]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text("1 hora",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.yellow[600]),
              color: Colors.yellow[600].withOpacity(0.25),
              /* boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(1, 1)
                )
              ] */
            ),
            child: Text('Perdido', 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow[800]
              ) 
            ),
          ),
          SizedBox(height: 10),
          Text('that famous sing mind fact equally total thirty far beside mouth deal wild occasionally everybody drop simply worker rocket doing control please impossible road',
            style: TextStyle(
              height: 1.5
            ),
          ),
          SizedBox(height: 15),
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://source.unsplash.com/UtrE5DcgEyg/700x500'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/id/177/400/400'),
                        fit: BoxFit.cover
                      ),
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/id/167/400/400'),
                        fit: BoxFit.cover
                      ),
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/id/164/400/400'),
                        fit: BoxFit.cover
                      ),
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 80, top: 3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text('+120',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
              /* Row(
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Icon(Icons.mode_comment, color: Colors.grey),
                  ),
                  SizedBox(width: 5),
                  Text('45',
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.favorite, color: Colors.grey, size: 28),
                  SizedBox(width: 5),
                  Text('32',
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ) */
            ],
          ),
          SizedBox(height: 10),
          /* SizedBox(height: 10),
          Text('Ver los 759 comentarios'),
          SizedBox(height: 10),
          Row(
            children: [
              Text('fedepalaush_',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Text('Se perdió?')
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://source.unsplash.com/_M6gy9oHgII/400x400'),
                    fit: BoxFit.cover
                  ),
                  color: Colors.grey,
                  shape: BoxShape.circle
                ),
              ),
              SizedBox(width: 10),
              Container(
                child: Text('Agrega un comentario...'),
              )
            ],
          ) */
        ],
      )
    );
  }
}