import 'package:flutter/material.dart';
import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/screens/screens.dart';


class SmallCard extends StatefulWidget{

  final Place place;

  get item => place;

  const SmallCard({
    Key key, 
    @required this.place,
  }): super(key: key);

  @override
  _SmallCardState createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> { 

  Widget _getWidget() {

    return Container(
      margin: EdgeInsets.only(bottom:5),
      child: Text(
        widget.place.type, 
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
          builder: (context) => PlaceShowScreen(
            place: widget.place
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
                      child: Image.network(
                        widget.place.image != null ? widget.place.image : 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
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
                        fit: widget.place.image != null ? BoxFit.cover : BoxFit.contain
                      ),
                    ),
                  ),
                  /* Container(
                    alignment: Alignment(-1, -1),
                    child: FavButtonWidget(
                      id: widget.place.id,
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
                      Text(widget.place.name, 
                        maxLines: 3, 
                        overflow: TextOverflow.ellipsis, 
                        style: Theme.of(context).textTheme.headline2
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(widget.place.address ?? 'Sin dirección', 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: CategoryWidget(count: widget.place.category.value)
                  )
                  /* ( widget.type == place.alojamiento ?
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