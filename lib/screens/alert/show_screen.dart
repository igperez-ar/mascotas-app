/* import 'package:flutter/material.dart';

class AlertWidget extends StatefulWidget {
  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                  shape: BoxShape.circle
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
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.yellow[600],
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(1, 1)
                )
              ]
            ),
            child: Text('Perdido', 
              style: TextStyle(
                fontWeight: FontWeight.bold
              ) 
            ),
          ),
          SizedBox(height: 10),
          Text('that famous sing mind fact equally total thirty far beside mouth deal wild occasionally everybody drop simply worker rocket doing control please impossible road'),
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 200,
                color: Colors.green[100],
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
} */