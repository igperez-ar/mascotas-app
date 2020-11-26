import 'package:flutter/material.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/imagenetwork_widget.dart';

class CardAdoptWidget extends StatelessWidget {
  final Pet pet;

  const CardAdoptWidget({
    Key key,
    this.pet,
  }) : super(key: key); 

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
                      Icon(Icons.favorite_border)  
                    ],
                  ),
                  SizedBox(height: 5),
                  ( pet.breed.kind != null && pet.birthDate != null
                    ? Text('${pet.breed.kind.name} de ${DateTime.now().difference(pet.birthDate)}',
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