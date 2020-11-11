import 'dart:math';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';

import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';

class PetShowScreen extends StatefulWidget {
   final String image;
   final String name;
   final String gender;
   final String age;
   final List colors;
   final String breed;

  const PetShowScreen({
    Key key, 
    this.image,
    this.name,
    this.gender,
    this.age,
    this.colors,
    this.breed,
  }): super(key: key);

  @override
  _PetShowScreenState createState() => _PetShowScreenState();
}

class _PetShowScreenState extends State<PetShowScreen> {

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

  /* List<Widget> _getWidget() {
    Widget _getChip(String title) => Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
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
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15
        )
      ),
    );

    if (widget.type == Establecimiento.alojamiento) {
      if (widget.establecimiento.clasificacion != null &&
          widget.establecimiento.clasificacion != '')
        return [_getChip(widget.establecimiento.clasificacion.nombre)];

    } else {
      if (widget.establecimiento.actividades.isNotEmpty) {
        return widget.establecimiento.actividades.map<Widget>(
          (actividad) => _getChip(actividad.nombre)
        ).toList();
      }
    }

    return [];
  } */

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
      bottomNavigationBar: 
      Container(
        height: 55,
        margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
        child: RaisedButton(
          onPressed: () {}, 
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text('Adoptar', style: TextStyle(fontSize: 16),)
          )
        ),
      ),
      body: Stack(
        children: [
          Image.network(
            widget.image,
            /* 'https://source.unsplash.com/AllEP6K_TAg/1200x1300', */
            fit: BoxFit.cover,
            height: 450,
          ),
          ListView(
            controller: _scrollController,
            children: <Widget>[ 
              Container(
                margin: EdgeInsets.only(top: 400.0),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Container( 
                      margin: EdgeInsets.only(bottom: 20),
                      height: 400.0,
                    ), */
                    Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 5, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.name, 
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Icon(Icons.favorite_border, size: 30,)
                        ],
                      ),
                    ),
                    Text(widget.breed,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey[100].withOpacity(0.6)
                      ),
                      margin: EdgeInsets.symmetric(vertical: 30),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text('Colores',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: widget.colors.map<Widget>((e) => Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.white, width: 2),
                                        color: e
                                      ),
                                    )
                                  ).toList()
                                )
                              ],
                            ),
                            VerticalDivider( thickness: 1,),
                            Column(
                              children: [
                                Text('Edad',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(/* '2 años' */widget.age,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider( thickness: 1,),
                            Column(
                              children: [
                                Text('Género',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(/* 'Femenino' */widget.gender,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      )
                    ),
                    /* Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 30,
                          color: Colors.green[800],
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Tierra del Fuego, Ushuaia', 
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.clip,
                          )
                        )
                      ]
                    ),
                    SizedBox(height: 20), */
                    Text('Sobre mi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('light bit plenty none several electric west box strength frequently shorter breeze twelve daughter stretch drew twenty feet pour snake go trap back union plane club attached land trade spell neighbor protection living dropped forward lovely real hall vast general earlier angle captain sentence battle involved can he',
                      style: TextStyle(
                        height: 1.4
                      ),
                    )
                    /* Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Alejando Alvarez sin tilde',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text('Dueño',
                                        style: TextStyle(
                                          color: Colors.grey
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                child: Text('28/06/2020',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('light bit plenty none several electric west box strength frequently shorter breeze twelve daughter stretch drew twenty feet pour snake go trap back union plane club attached land trade spell neighbor protection living dropped forward lovely real hall vast general earlier angle captain sentence battle involved can he',
                            style: TextStyle(
                              height: 1.4
                            ),
                          )
                        ],
                      ),
                    ) */
                    /* Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: MapCardWidget(
                        type: widget.type,
                        lat: widget.establecimiento.lat,
                        lng: widget.establecimiento.lng
                      )
                    ),
                    SizedBox(height: 40),
                    ScoreReviewWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
                    ),
                    MemoriesWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
                    ) */
                  ],
                )
              )
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
                title: Text(widget.name),
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