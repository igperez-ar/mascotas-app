import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlertWidget extends StatefulWidget {
  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text("12/09/20",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
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
                /* color: Colors.green[100], */
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://source.unsplash.com/UtrE5DcgEyg/700x500'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 5),
                      Text('Ver en mapa',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text('+3',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.thumb_up),
                  SizedBox(width: 10),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Icon(Icons.reply, size: 35),
                  ),
                  SizedBox(width: 10),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Icon(Icons.mode_comment),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
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
          )
        ],
      )
    );
  }
}