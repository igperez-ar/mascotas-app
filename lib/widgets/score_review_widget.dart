import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/screens/screens.dart';

class ScoreReviewWidget extends StatefulWidget {

  final int placeId;

  const ScoreReviewWidget({
    Key key,
    @required this.placeId,
  }) : super(key: key);

  @override
  _ScoreReviewWidgetState createState() => _ScoreReviewWidgetState();
}

class _ScoreReviewWidgetState extends State<ScoreReviewWidget> {
  /* bool _open = false; */
  bool _updated = false;
  Usuario selfUsuario;

  @override
  void initState() {
    super.initState();

    final state = BlocProvider.of<AutenticacionBloc>(context).state;
    if (state is AutenticacionAuthenticated) {
      selfUsuario = state.usuario;
    }
  }

  void _updateState() {
    setState(() {
      _updated = !_updated;
    });
  }

  final List<Map<String, Object>> iconList = [
    {'name': Icons.sentiment_very_dissatisfied,
     'color': Colors.red
    },
    {'name': Icons.sentiment_dissatisfied,
     'color': Colors.orange
    },
    {'name': Icons.sentiment_neutral,
     'color': Colors.yellow
    },
    {'name': Icons.sentiment_satisfied,
     'color': Colors.lightGreen
    },
    {'name': Icons.sentiment_very_satisfied,
     'color': Colors.green
    },
  ];

  Widget _icon(int number, {bool min = true}) {
    return Icon(
      iconList[number-1]['name'],
      color: iconList[number-1]['color'],
      size: (min ? 24 : 55),
    );
  }

  Widget _bar(Icon icon, double count) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          SizedBox(width: 5),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: count,
                backgroundColor: Colors.grey[300],
              )
            )
          )
        ],
      ),
    );
  }

  Widget _buildCalificar(Function onSuccess) {
    return DetailSectionWidget(
      title: "Califica este lugar",
      subtitle: "Comparte tu opinión con otros usuarios",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ScoreWidget(
              onPress: (value) => Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => ReviewShowScreen(
                    placeId: widget.placeId,
                    selected: value,
                  )
                )
              ).then((_) => _updateState()),
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ReviewShowScreen(
                  placeId: widget.placeId,
                )
              )
            ).then((_) => _updateState()),
            padding: EdgeInsets.zero,
            textColor: Colors.teal,
            child: Text('Escribe una reseña', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          )
        ],
      )
    );
  }

  Widget _buildComentario(Review review) {
    return DetailSectionWidget(
      title: 'Tu reseña',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewWidget(
            own: true,
            review: review,
            onDelete: _updateState,
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ReviewShowScreen(
                  placeId: widget.placeId,
                  update: review,
                )
              )
            ).then((_) => _updateState()),
            padding: EdgeInsets.zero,
            textColor: Colors.teal,
            child: Text('Editar reseña', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          )
        ],
      )
    );
  }

  Widget _getAverage(List<Review> reviews) {
    final total = reviews.length;
    List<Widget> _children = [];

    for (var i = 5; i >= 1; i--) {
      final int count = reviews
        .where(
          (element) => element.score == i
        )
        .length;
      _children.add(
        _bar(_icon(i), count/total),
      );
    }

    return Column(
      children: _children
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(QueryPlace.getReviews),
        variables: {
          "placeId": widget.placeId
        }
      ), 
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }

        final List<Review> reviews = result.data['reviewsByPlace']
          .map<Review>((e) => Review.fromJson(e))
          .toList();

        if (reviews.isEmpty) {
          return Column(
            children: [
              _buildCalificar(refetch),
              DetailSectionWidget(
                title: 'Reviewes y reseñas',
                child: Text('Aún no se publican reseñas.'),
              )
            ],
          );
        }
        
        final double promedio = reviews
          .map((review) => review.score)
          .reduce((value, element) => value + element) / reviews.length;

        return Column(
          children: [
            Builder(
              builder: (context) {

                if (selfUsuario != null) {
                  final Review selfReview = reviews.singleWhere(
                    (review) => review.user.id == selfUsuario.id,
                    orElse: () => null,  
                  );

                  if (selfReview != null) {
                    return _buildComentario(selfReview);

                  } else {
                    return _buildCalificar(refetch);
                  }
                }

                return Container();
              }
            ),
            DetailSectionWidget(
              title: "Reviews y reseñas",
              actions: reviews.length > 2 
                ? [{
                    'icon': Icons.arrow_forward,
                    'onPressed': () => Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => ReviewsScreen(
                          reviews: reviews,
                        )
                      )
                    ),
                  }] 
                : null,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ 
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    _icon(promedio.round(), min:false),
                                    SizedBox(width: 5),
                                    Text(promedio.toStringAsPrecision(2),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(reviews.length.toString(),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                )
                              ],
                            )
                          ),
                          Expanded(
                            flex: 3,
                            child: _getAverage(reviews),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: reviews
                        .getRange(0, (reviews.length > 2 ? 2 : reviews.length))
                        .map<Widget>((review) {
                          if (selfUsuario == null || review.user.id != selfUsuario.id)
                            return Column(
                              children: [
                                Divider(height: 30, thickness: 1.5, color: Colors.grey[300],),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: ReviewWidget(
                                    review: review
                                  )
                                )
                              ],
                            );

                          return Container();
                      }).toList(),
                    ),
                    (reviews.length > 2
                      ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: FlatButton(
                            onPressed: () => Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => ReviewsScreen(
                                  reviews: reviews,
                                )
                              )
                            ),
                            padding: EdgeInsets.zero,
                            textColor: Colors.teal,
                            child: Text('Ver todas las reseñas', 
                              style: TextStyle(
                                fontSize: 16
                              ),
                            )
                          )
                      )
                      : Container()
                    )
                  ],
              )
            )
          ],
        );
      }
    );
  }
}