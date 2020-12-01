import 'package:flutter/material.dart';
import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/screens/screens.dart';


class AlertSmallWidget extends StatefulWidget{
  final Alert alert;
  final Future<String> distance;

  get item => alert;

  const AlertSmallWidget({
    Key key,
    @required this.alert,
    this.distance,
  }) : super(key: key); 

  @override
  _AlertSmallWidgetState createState() => _AlertSmallWidgetState();
}

class _AlertSmallWidgetState extends State<AlertSmallWidget> { 

  Widget _getWidget() {

    return Container(
      margin: EdgeInsets.only(bottom:5),
      child: Text(
        widget.alert.type.name, 
        style: Theme.of(context).accentTextTheme.headline1,
        maxLines: 1,
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => AlertShowScreen(
            alert: widget.alert
          )
        )
      ),
      child: Container(
        height: 150,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 2)
            )
          ]
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget> [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    child: Container(
                      color: Colors.white,
                      child: ImageNetworkWidget(
                        source: widget.alert.images[0].url,
                      )
                    ),
                  ),
                  /* Container(
                    alignment: Alignment(-1, -1),
                    child: FavButtonWidget(
                      id: widget.alert.id,
                      type: widget.type,
                    )
                  ), */
                ], 
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Stack(
                children: <Widget>[ 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _getWidget(),
                      Text(widget.alert.user.name, 
                        maxLines: 3, 
                        overflow: TextOverflow.ellipsis, 
                        style: Theme.of(context).textTheme.headline2
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(widget.alert.description ?? "", 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3
                        ),
                      ),
                    ],
                  ),
                  /* Align(
                    alignment: Alignment.bottomLeft,
                    child: CategoryWidget(count: widget.alert.category.value)
                  ) */
                  /* ( widget.type == alert.alojamiento ?
                    : Container() 
                  )  */
                ],
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}