import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';


class PlacesScreen extends StatefulWidget {
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  int filtered;
  bool showMap = false;

  List<SmallCard> _getFavoritos(
    List<Favorito> favoritos, List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos
  ) {
    final List<SmallCard> _children = [];

    for (var item in favoritos) {
      var establecimiento;

      if (item.tipo == Establecimiento.alojamiento) {
        establecimiento = alojamientos.singleWhere(
          (element) => element.id == item.id,
          orElse: () => null  
        );

      } else {
        establecimiento = gastronomicos.singleWhere(
          (element) => element.id == item.id,
          orElse: () => null  
        );
      }

      if (establecimiento != null)
        _children.add(
          SmallCard(
            type: item.tipo,
            establecimiento: establecimiento,
          )
        );
    }

    return _children;
  }

  Widget _getCard(String image, String title, String address) {
    double _width = MediaQuery.of(context).size.width;

    return GestureDetector(
      /* onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => EstablecimientoShowScreen(
            type: null,
            establecimiento: null
          )
        )
      ), */
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
                      child: Image.network(
                        image != null ? image : 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
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
                        fit: image != null ? BoxFit.cover : BoxFit.contain
                      ),
                    ),
                  ),
                  /* Align(
                    alignment: Alignment(0.95, -1),
                    child: FavButtonWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
                    )
                  ), */
                  /* _getWidget() */
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
                    Text(title, 
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(address ?? 'Sin direccion', 
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /* ( widget.type == Establecimiento.alojamiento ?
                            CategoryWidget(count: widget.establecimiento.categoria.valor)
                          : Container()
                        ), */
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
                            Padding(padding: EdgeInsets.only(left:5)),
                            Text(
                              /* distance ?? */ 'Cargando...',
                              style: Theme.of(context).textTheme.headline3
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
                onPressed: () => Navigator.pushNamed(
                  context, '/filtros', 
                  arguments: {
                    'context': context,
                    'favoritos': true
                  }
                ),
              );
            }
          ),
          IconButton(
            icon: Icon(showMap ? Icons.format_list_bulleted : Icons.map, size: 30.0,), 
            onPressed: () { 
              setState(() {
                showMap = !showMap;
              });
            } 
          )
        ],
      ),
      body: BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
        builder: (context, estState) {

            /* if (Failure) {
              return EmptyWidget(
                title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
                uri: 'assets/images/undraw_server_down.svg',
              );
            } */

            /* if (Success) { */
                    
              if (!showMap) {

                return ListView(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
                  children: [
                    /* _getCard('image', 'title', address) */
                  ],
                );
              } else {

                return MapCarousel(
                  cards: []
                );
              }
            /* } */

            /* return Center(
              child: CircularProgressIndicator(),
            ); */
        },
      )
    );
  }
}