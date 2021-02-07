import "package:dashed_container/dashed_container.dart";
import "package:flutter/material.dart";

import "package:mascotas_app/widgets/widgets.dart";
import "package:mascotas_app/models/models.dart";

class PlaceShowScreen extends StatefulWidget {
  final Place place;

  const PlaceShowScreen({
    Key key, 
    @required this.place,
  }): super(key: key);

  @override
  _PlaceShowScreenState createState() => _PlaceShowScreenState();
}

class _PlaceShowScreenState extends State<PlaceShowScreen> {

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 350.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  Widget _getChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1, 
            offset: Offset(2, 2),
          )
        ]
      ),
      child: Text(
        widget.place.type,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15
        )
      ),
    );
  }

  Widget _checkItem(String title) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width / 2.5,
      child: Row(
        children: <Widget>[
          Container(
            width: 25,
            height: 25,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration( 
              color: Colors.teal[300],
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 1, 
                  offset: Offset(1, 1),
                )
              ],
            ) 
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.clip,
            )
          )
        ],
      )
    );  
  }

  @override
  Widget build(BuildContext context) {   
    
    return Scaffold(
      body: Stack(
        children: [
          ImageNetworkWidget(
            baseUrl: "",
            source: widget.place.image,
            height: 450,
          ),
          /* Image.network(
            widget.place.image != null 
              ? widget.place.image 
              :"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU",
            fit: BoxFit.cover,
            height: 450,
          ), */
          ListView(
            controller: _scrollController,
            children: <Widget>[ 
              Container( 
                height: 400.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical( 
                    top: Radius.circular(30)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, -2)
                    )
                  ]
                ),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          constraints: BoxConstraints(maxWidth: 280),
                          child: _getChip()
                        ),
                        /* SizedBox(
                          height: 60,
                          child: FavButtonWidget(
                            id: widget.place.id,
                            type: widget.type,
                            size: FavSize.big
                          ),
                        ), */
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(widget.place.name, 
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CategoryWidget(
                        count: widget.place.category.value, 
                        size: 30
                      ),
                    ),
                    Divider(thickness: 1.5, height: 10),
                    SizedBox(height: 40),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 30,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.place.address ?? "Sin dirección", 
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17
                            ),
                            overflow: TextOverflow.clip,
                          )
                        )
                      ]
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: MapCardWidget(
                        lat: widget.place.lat,
                        lng: widget.place.lng
                      )
                    ),
                    SizedBox(height: 40),
                    ScoreReviewWidget(
                      placeId: widget.place.id,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 85,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _isScrolled ? 1.0 : 0.0,
            curve: Curves.ease,
            child: Container(
              height: 85,
              child: AppBar(
                title: Text(widget.place.name),
              )
            ),
          ),
        ],
      ),
    );
  }
}




/* Container(
  height: _width * 0.8,
  width: _width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment(0, 0),
      colors: [Colors.grey[50], Color.fromRGBO(150, 150, 150, 0.01)]
    )
  ),
), */