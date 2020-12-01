import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class ReviewWidget extends StatefulWidget {

  final Review review;
  final bool own;
  final Function onDelete;

  const ReviewWidget({
    Key key,
    @required this.review,
    this.own = false,
    this.onDelete
  }) : super(key: key);

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  /* bool isUseful = false;
  bool isUseless = false; */
  String createdAt;

  Review get review => widget.review; 

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

  /* _changeUseful() {
    if (this.isUseful) 
      this.setState(() { 
        isUseful = false;
      }); 
    else
      this.setState(() { 
        isUseful = true;
        isUseless = false;
      });
  }

  _changeUseless() {
    if (this.isUseless) 
      this.setState(() { 
        isUseless = false;
      }); 
    else
      this.setState(() { 
        isUseless = true;
        isUseful = false;
      });
  } */

  @override
  void initState() {
    super.initState();

    createdAt = DateFormat('dd/mm/yy').format(review.createdAt);
  }

  Widget _icon(int number, {bool min = true}) {
    return Icon(
      iconList[number-1]['name'],
      color: iconList[number-1]['color'],
      size: (min ? 24 : 65),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      /* margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /* Divider(height: 30, thickness: 1.5, color: Colors.grey[300],), */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  /* ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SvgPicture.network('https://image.flaticon.com/icons/svg/3011/3011279.svg',
                      height: 45,
                      width: 45,
                    )
                  ), */
                  ProfileImage(
                    image: widget.review.user.image, 
                    size: ProfileImageSize.small
                  ),
                  SizedBox(width: 10),
                  Text(review.user.name, style: Theme.of(context).textTheme.headline4
                  )
                ]
              ),
              /* (widget.own 
                ? Mutation(
                    options: MutationOptions(
                      documentNode: gql(QueryReview.deleteReview)
                    ),
                    builder: (RunMutation deleteReview, QueryResult result) {
                      return PopupMenuButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.more_vert, color: Colors.grey[400]),
                        onSelected: (value) {
                          deleteReview({
                            'reviewId': widget.review.id
                          });
                          if (widget.onDelete != null)
                            widget.onDelete();
                        },
                        itemBuilder: (context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            height: 35,
                            value: 1,
                            child: Text('Eliminar'),
                          ),
                        ],
                      );
                    },
                  )
                : Container()
              ), */
              /* Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.thumb_up, color: (this.isUseful ? Colors.lightGreen : Colors.grey[400])),
                    onPressed: _changeUseful
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down, color: (this.isUseless ? Colors.red : Colors.grey[400])),
                    onPressed: _changeUseless
                  )
                ],
              ) */
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              _icon(review.score),
              SizedBox(width: 5),
              Text(createdAt, style: TextStyle(color: Colors.grey[600]),)
            ],
          ),
          SizedBox(height: 10),
          Text(review.description,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}