import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class ReviewShowScreen extends StatefulWidget {

  final int selected;
  final int placeId;
  final Review update;

  const ReviewShowScreen({
    Key key,
    this.selected,
    @required this.placeId,
    this.update
  }) : super(key: key);

  @override
  _ReviewShowScreenState createState() => _ReviewShowScreenState();
}

class _ReviewShowScreenState extends State<ReviewShowScreen> {
  int selected;
  bool _isDisabled = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.selected != null)
      setState(() {
        selected = widget.selected;
      });

    if (widget.update != null) {
      final Review review = widget.update;
      final score = review.score;

      setState(() {
        selected = score;
        _textEditingController.text = review.description;
      });
    }

    if (selected == null || _textEditingController.text.isEmpty)
      setState(() {
        _isDisabled = true;
      });
  }

  /* Widget _getDestacables() {
    return Query(
      options: QueryOptions(
        documentNode: gql(QueryReview.getDestacables)
      ), 
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
          return Text(result.exception.toString());
        }
          if (result.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
          final destacables = result.data['destacables'];
          return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: destacables.length,
          itemBuilder: (context, index) {
            final item = destacables[index];
              return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(5),
              width: 110,
              child: GestureDetector(
                onTap: () => this.setState(() {
                  this.destacableSelected = this.destacableSelected == item['id'] ? null : item['id']; 
                }),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: this.destacableSelected == item['id'] ? Colors.teal[300] : Colors.transparent,
                          width: 5
                        )
                      ),
                    ),
                    Text(item['nombre'],
                      style: TextStyle(
                        fontWeight: this.destacableSelected == item['id'] ? FontWeight.bold : FontWeight.normal
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              )
            );
          }
        );
      }
    );
  } */

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calificar', 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.pop(context),
          )
        ),
        body: BlocBuilder<AutenticacionBloc,AutenticacionState>(
          builder: (context, state) {
            if (state is AutenticacionAuthenticated){
              return  SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    /* ( this.selected != null 
                      ? Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(selected.toString(),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          )
                        ) 
                      )
                      : Container()
                    ), */
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: ScoreWidget(
                        selected: this.selected,
                        onPress: (item) => this.setState(() {
                          this.selected = item; 
                        }),
                      )
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 200, maxHeight: 300),
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
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
                              maxLength: 500,
                              controller: _textEditingController,
                              onChanged: (_) {
                                setState(() {
                                  _isDisabled = _textEditingController.text.isEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Describe tu experiencia',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              minLines: 9,
                              maxLines: null,
                            ),
                          )
                        ]
                      )
                    ),
                    SizedBox(height: 20),
                    Mutation(
                      options: MutationOptions(
                        documentNode: gql(widget.update != null
                          ? QueryReview.updateReview
                          : QueryReview.addReview
                        ),
                        onCompleted: (_) => Navigator.of(context).pop(),
                      ),
                      builder: (RunMutation runMutation, QueryResult result) {

                        return RaisedButton(
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Container(
                            width: 150,
                            height: 40,
                            alignment: Alignment.center,
                            child: Text('Publicar', style: TextStyle(fontSize: 16),)
                          ),
                          onPressed: (_isDisabled || selected == null) 
                            ? null 
                            : () {
                              if (widget.update != null) {
                                /* runMutation({
                                  "reviewId": widget.update.id,
                                  "score": selected['id'],
                                  "comentario": _textEditingController.text,
                                  "destacableId": destacableSelected
                                }); */

                              } else {
                                runMutation({
                                  "score": selected,
                                  "description": _textEditingController.text,
                                  "placeId": widget.placeId,
                                  "userId": state.usuario.id
                                });
                              }
                          },
                        );
                      },
                    )
                  ],
                )
              );
            }

            return Expanded(
              child: Center(
                child: CircularProgressIndicator()
              )
            );
          }
        )
      )
    );
  }
}