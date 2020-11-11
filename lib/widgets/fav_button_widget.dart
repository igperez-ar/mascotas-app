import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/widgets.dart';


enum FavSize {
  small,
  big
}


class FavButtonWidget extends StatefulWidget {
  final int id;
  final Establecimiento type;
  final FavSize size;
  
  const FavButtonWidget({
    Key key, 
    @required this.id,
    @required this.type,
    this.size = FavSize.small,
  }): super(key: key);

  @override
  _FavButtonWidgetState createState() => _FavButtonWidgetState();
}

class _FavButtonWidgetState extends State<FavButtonWidget> with TickerProviderStateMixin {
  FavoriteBloc _favoriteBloc;
  AutenticacionBloc _autenticacionBloc;

  var squareScale = 1.0;
  AnimationController _animationController;


  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      value: 1.0,
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: Duration(milliseconds: 130));
    _animationController.addListener(() {
      setState(() {
        squareScale = _animationController.value;
      });
    });
    super.initState();

    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _autenticacionBloc = BlocProvider.of<AutenticacionBloc>(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeFavorite(Favorite favorite) {

    if (_autenticacionBloc is AutenticacionAuthenticated) {
      if (favorite != null) {
        if (favorite.recuerdos.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmar'),
                content: Text('Esta acción eliminará los recuerdos añadidos a este lugar.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("Aceptar"),
                    onPressed: () {
                      _favoriteBloc.add(RemoveFavorite(favorite));
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          _favoriteBloc.add(RemoveFavorite(favorite));
        }
      } else {
        _animationController.forward().whenComplete(() => _animationController.reverse());

        _favoriteBloc.add(AddFavorite(
          Favorite(
            id: widget.id, 
            tipo: widget.type,
            recuerdos: List<String>()
          )
        ));
      }

    } else {
      SnackBarWidget.show(
        context,
        'Debes acceder para usar esta funcionalidad.', 
        SnackType.danger
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: (widget.size == FavSize.small ? 70 : 90),
      height: (widget.size == FavSize.small ? 70 : 90),
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: (widget.size == FavSize.small ? -8 : -12),
            child: Container( 
              height: (widget.size == FavSize.small ? 50 : 60),
              width: (widget.size == FavSize.small ? 45 : 55),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow( 
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 0.1,
                    offset: Offset(0,1.5)
                  )
                ]
              ),
            ),
          ),
          Positioned(
            top: (widget.size == FavSize.small ? -15 : -25),
            child: Icon(
              Icons.bookmark, 
              color: Theme.of(context).cardColor, 
              size: (widget.size == FavSize.small ? 70 : 90),
            )
          ),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              Favorite favorite; 
              
              if (state is FavoriteSuccess && _autenticacionBloc.state is AutenticacionAuthenticated) {
                favorite = state.favorite.firstWhere(
                  (element) => element.id == widget.id
                            && element.tipo == widget.type,
                  orElse: () => null
                );
              }

              return Positioned(
                top: -5,
                child: Transform.scale(
                  scale: squareScale,
                  child: IconButton(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      favorite != null ? Icons.favorite : Icons.favorite_border, 
                      color: (favorite != null ? Theme.of(context).iconTheme.color : Colors.grey[400]),
                      size: (widget.size == FavSize.small ? 45/1.5 : 40)
                    ),
                    onPressed: () => _changeFavorite(favorite)
                  )
                )
              );
            }
          ), 
        ],
      )
    );
  }
}