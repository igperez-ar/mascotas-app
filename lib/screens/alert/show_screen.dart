import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/widgets/widgets.dart';
import 'package:intl/intl.dart';

class AlertShowScreen extends StatefulWidget {
  final Alert alert;

  const AlertShowScreen({
    Key key,
    @required this.alert,
  }) : super(key: key);

  @override
  _AlertShowScreenState createState() => _AlertShowScreenState();
}

class _AlertShowScreenState extends State<AlertShowScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List<Comment> _comments;

  @override
  void initState() {
    super.initState();

    _comments = widget.alert.comments;
  }

  Widget _getComment(Comment comment) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          ProfileImage(
            image: comment.user.image,
            size: ProfileImageSize.small,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(comment.user.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 5),
              Text(comment.content)
            ],
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Alerta', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30.0), 
          onPressed: () => Navigator.of(context).pop()
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: [
                Row(
                  children: [
                    ProfileImage(
                      image: widget.alert.user.image,
                      size: ProfileImageSize.small,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.alert.user.name,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(DateFormat("d/M/y  H:m").format(widget.alert.createdAt),
                          style: TextStyle(
                            color: Colors.grey[600]
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.yellow[600]),
                        color: Colors.yellow[600].withOpacity(0.25),
                      ),
                      child: Text(widget.alert.type.name, 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[800]
                        ) 
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(widget.alert.description),
                SizedBox(height: 10),
                (widget.alert.images.isNotEmpty 
                  ? (widget.alert.images.length > 1
                      ? Container(
                          height: _width * 0.5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: widget.alert.images.map<Widget>(
                              (e) => Container(
                                width: _width * 0.5,
                                margin: EdgeInsets.only(right: 10),
                                child: ImageNetworkWidget(
                                  source: e.url,
                                )
                              )
                            ).toList(),
                          )
                        )
                      : Container(
                          height: _width * 0.5,
                          width: _width,
                          child: ImageNetworkWidget(
                            source: widget.alert.images[0].url,
                          )
                        )
                    )
                  : Container()
                ),
                SizedBox(height: 25),
                (widget.alert.comments.isNotEmpty
                  ? DetailSectionWidget(
                      title: "Comentarios",
                      child: Column(
                        children: _comments.map<Widget>(
                          (e) => _getComment(e)
                        ).toList(),
                      )
                    )
                  : Container()
                )
              ],
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<AutenticacionBloc, AutenticacionState>(
              builder: (context, state) {

                if (state is AutenticacionAuthenticated) {
                  return Container(
                    margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 15),
                    child: Row(
                      children: [
                        ProfileImage(
                          image: state.usuario.image,
                          size: ProfileImageSize.small,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(minHeight: 45, maxHeight: 150),
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey[400],
                                width: 1
                              )
                            ),
                            child: Flex( 
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: TextField(
                                    textCapitalization: TextCapitalization.sentences,
                                    controller: _textEditingController,
                                    decoration: InputDecoration(
                                      hintText: 'Escribe un comentario',
                                      hintStyle: TextStyle(color: Colors.grey[600]),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    minLines: 1,
                                    maxLines: 6,
                                  ),
                                ),
                                Mutation(
                                  options: MutationOptions(
                                    documentNode: gql(QueryComment.addComment),
                                  ),
                                  builder: (RunMutation addComment, QueryResult result) {
                                    
                                    return IconButton(
                                      icon: Icon(Icons.send, color: Colors.grey[800],),
                                      onPressed: () {
                                        if (_textEditingController.text.trim().isNotEmpty) {
                                          addComment({
                                            "alertId": widget.alert.id,
                                            "userId": state.usuario.id,
                                            "content": _textEditingController.text
                                          });
                                          setState(() {
                                            _comments.add(
                                              Comment(
                                                content: _textEditingController.text,
                                                user: state.usuario
                                              )
                                            );
                                          });
                                          _textEditingController.clear();
                                          BlocProvider.of<AlertsBloc>(context).add(FetchAlerts());
                                        }
                                      }
                                    );
                                  },
                                )
                              ]
                            )
                          )
                        )
                      ]
                    )
                  );
                }

                return Container();
              }
            ),
          ),
        ],
      )
    );
  }
}