import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/providers/base_provider.dart';
import 'package:mascotas_app/screens/alert/show_screen.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class AlertWidget extends StatefulWidget {

  /* final bool compact; */
  final Alert alert;
  final Future<String> distance;

  const AlertWidget({
    Key key,
    @required this.alert,
    /* this.compact = false, */
    this.distance,
  }) : super(key: key); 

  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {

  /* Widget _buildCompact() {
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
                      Text(widget.alert.user.name,
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
                child: Text(widget.alert.type.name, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[800]
                  ) 
                ),
              ),
              Text(widget.alert.createdAt.toString(),
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
          (widget.alert.images.isNotEmpty
            ? Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ImageNetworkWidget(source: widget.alert.images[0].url)
                    ),
                    SizedBox(width: 5),
                    (widget.alert.images.length >= 3
                      ? Column(
                          children: [
                            Expanded(
                              child: ImageNetworkWidget(source: widget.alert.images[1].url)
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: ImageNetworkWidget(source: widget.alert.images[2].url)
                            ),
                          ],
                        )
                      : 
                      Container()
                    )
                  ],
                ),
              )
            : Container()
          ),
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
  } */

  String _getTimeDifference() {
    final Duration time = DateTime.now().difference(widget.alert.createdAt);

    if (time.inDays >= 1) {
      return "${time.inDays} día${time.inDays > 1 ? 's' : ''}";

    } else {
      if (time.inHours >= 1) {
        return "${time.inHours} hora${time.inHours > 1 ? 's' : ''}";

      } else {
        if (time.inMinutes >= 1) {
          return "${time.inMinutes} minuto${time.inMinutes > 1 ? 's' : ''}";

        } else {   
          if (time.inSeconds >= 1) {
            return "${time.inSeconds} segundo${time.inSeconds > 1 ? 's' : ''}";

          } else {
            return "0 segundos";
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    /* if (widget.compact) {
      return _buildCompact();
    } */

    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => AlertShowScreen(
            alert: widget.alert
          )
        )
      ),
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(maxHeight: _width),
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ProfileImage(
                        image: widget.alert.user.image,
                        size: ProfileImageSize.small,
                      /* decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/id/1005/200/200'))
                      ), */
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.alert.user.name,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey, size: 20,),
                            SizedBox(width: 2),
                            FutureBuilder(
                              future: widget.distance,
                              builder: (context, snapshot) {
                                  return Text(snapshot.hasData ? snapshot.data : "Cargando...",
                                  style: TextStyle(
                                    color: Colors.grey[600]
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(_getTimeDifference(),
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
              ),
              child: Text(widget.alert.type.name, 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[800]
                ) 
              ),
            ),
            SizedBox(height: 10),
            Text(widget.alert.description,
              style: TextStyle(
                height: 1.5
              ),
            ),
            SizedBox(height: 15),
            (widget.alert.images.isNotEmpty
              ? Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: ImageNetworkWidget(
                          source: widget.alert.images[0].url,
                        ),
                      )
                    ],
                  )
                )
              : Container()
            ),
            /* Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${BaseProvider.mediaURL}${widget.alert.images[0]}"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ],
            ), */
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* Stack(
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
                ), */
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
            SizedBox(height: 5),
            (widget.alert.comments.isNotEmpty
              ? Text('Ver los ${widget.alert.comments.length} comentarios')
              : Container()
            )
            /* SizedBox(height: 10),
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
      )
    );
  }
}