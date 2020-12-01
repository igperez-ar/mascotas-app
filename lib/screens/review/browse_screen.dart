import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class ReviewsScreen extends StatelessWidget {

  final List reviews;

  const ReviewsScreen({
    Key key,
    this.reviews
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews y reseñas', 
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        /* leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: 30.0,), 
          onPressed: () => Navigator.pop(context),
        ) */
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: reviews.length,
        itemBuilder: (context, index) => Column(
          children: [
            (index > 0 
              ? Divider(height: 30, thickness: 1.5, color: Colors.grey[300],)
              : Container()
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ReviewWidget(
                review: Review.fromJson(reviews[index])
              )
            )
          ],
        ),
      )
    );
  }
}