import 'package:flutter/material.dart';
import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/screens/screens.dart';


class CardWidget extends StatefulWidget{
  
  final Place place;
  final Future<String> distance;

  const CardWidget({
    Key key, 
    @required this.place,
    this.distance
  }): super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}


class _CardWidgetState extends State<CardWidget> {
  bool liked;

  Widget _getChip() {
    
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top:10, left:10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2, 
              offset: Offset(2, 2),
            )
          ]
        ),
        child: Text(widget.place.type,
          style: Theme.of(context).accentTextTheme.headline1
        ),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => PlaceShowScreen(
            place: widget.place
          )
        )
      ),
      child: Container(
        margin: EdgeInsets.only(top:20),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[ 
            Container(
              height: _width * 0.4,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[ 
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: Container(
                      color: Colors.white,
                      child: ImageNetworkWidget(
                        baseUrl: "",
                        source: widget.place.image
                      )
                    ),
                  ),
                  /* Align(
                    alignment: Alignment(0.95, -1),
                    child: FavButtonWidget(
                      id: widget.place.id,
                      type: widget.type,
                    )
                  ), */
                  _getChip()
                ]
              )
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.place.name, 
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(widget.place.address ?? 'Sin direccion', 
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CategoryWidget(count: widget.place.category.value),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
                            Padding(padding: EdgeInsets.only(left:5)),
                            FutureBuilder(
                              future: widget.distance,
                              builder: (context, snapshot) {

                                return Text(snapshot.hasData ? snapshot.data : "Cargando...",
                                  style: Theme.of(context).textTheme.headline3
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]
        )
      )
    );
  }
}