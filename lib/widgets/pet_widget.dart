import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/imagenetwork_widget.dart';

class PetWidget extends StatelessWidget {
  final Pet pet;

  const PetWidget({
    Key key,
    this.pet,
  }) : super(key: key); 

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => PetShowScreen(
            pet: pet,
          )
        )
      ),
      child: Container(
        width: 180,
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1)
            )
          ]
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  (pet.images.isNotEmpty
                    ? ImageNetworkWidget(
                        source: pet.images[0].url,
                      )
                    : Container()
                  )
                ],
              ),
            ),
            /* Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover
                )
              ),
            ), */
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pet.name,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      /* BlocBuilder<AutenticacionBloc,AutenticacionState>(
                        builder: (context, state) {
                          
                          if (state is AutenticacionAuthenticated) {
                            if (pet.tenures.every((element) => element.user.id != state.usuario.id)) {
                              return Icon(Icons.favorite_border);
                            }
                          }

                          return Container();
                        },
                      ) */
                    ],
                  ),
                  SizedBox(height: 5),
                  ( pet.breed.kind != null && pet.birthDate != null
                    ? Text('${pet.breed.kind.name} de ${_getAge(pet.birthDate)}',
                        style: TextStyle(
                          color: Colors.grey[600]
                        ),
                      )
                    : Container()
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}