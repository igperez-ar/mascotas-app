import 'package:flutter/material.dart';
import 'package:mascotas_app/screens/screens.dart';

class CardAdoptWidget extends StatelessWidget {
  
  final String name; 
  final String age; 
  final String image; 
  final String species; 
  final String gender; 
  final String breed; 
  final List colors;

  const CardAdoptWidget({
    Key key,
    this.name,
    this.image,
    this.species,
    this.gender,
    this.age,
    this.breed,
    this.colors,
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => PetShowScreen(
            image: image,
            name: name,
            age: age,
            gender: gender,
            breed: breed,
            colors: colors
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
                  Image.network(
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
                    fit: BoxFit.cover
                  ),
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
                      Text(name,
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
                  Text('$species de $age',
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
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