import 'dart:math';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';

import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';


class PetShowScreen extends StatefulWidget {
   final Pet pet;

  const PetShowScreen({
    Key key,
    this.pet,
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

  String _getAge(DateTime date) {
    DateTime now = DateTime.now();
    int years = now.year - date.year;
    int months = now.month - date.month;

    if (years > 0) {
      return "$years años";

    } else {
      if (months > 0) {
        return "$months meses";

      } else {
        return "semanas";
      }
    }
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
    final double _width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      bottomNavigationBar: (widget.pet.inAdoption ?? false 
        ? Container(
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
          )
        : null
      ),
      body: Stack(
        children: [
          ImageNetworkWidget(
            source: widget.pet.images[0].url,
            height: 500,
            width: _width,
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
                    Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.pet.name, 
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert, size: 30, color: Colors.grey,)
                          )
                        ],
                      ),
                    ),
                    Text(widget.pet.breed.kind.name,
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
                                Text('Raza',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(widget.pet.breed.name,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(thickness: 1),
                            Column(
                              children: [
                                Text('Edad',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(_getAge(widget.pet.birthDate),
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
                                Text('Sexo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(widget.pet.sex == "F" ? "Hembra" : "Macho",
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
                    (widget.pet.description != null && widget.pet.description.isNotEmpty
                      ? DetailSectionWidget(
                          title: "Sobre mi",
                          child: Text(widget.pet.description,
                            style: TextStyle(
                              height: 1.4
                            ),
                          )
                        )
                      : Container()
                    ),
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
                title: Text(widget.pet.name),
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