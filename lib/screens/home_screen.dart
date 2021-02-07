import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mascotas_app/widgets/widgets.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget _buildAdCard(String image) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(2,2)
          )
        ],
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget _buildCarousel() {

    return CarouselSlider(
        items: [
          _buildAdCard("assets/images/anuncio1.jpg"),
          _buildAdCard("assets/images/anuncio2.jpg"),
          _buildAdCard("assets/images/anuncio3.jpg")
        ],
        options: CarouselOptions(
          height: 210,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          initialPage: 0
        ),
    );
  }

  Widget _buildCategory(String title, IconData icon) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.red[300],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white)
          ),
          Text(title)
        ],
      )
    );
  }

  @override 
  void initState() {
    super.initState();

    /* _establecimientoBloc = BlocProvider.of<EstablecimientosBloc>(context);
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context); */
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 50.0,
              child: SvgPicture.asset("assets/images/isologo-petcommunity.svg",
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            SvgPicture.asset("assets/images/logo-petcommunity.svg",
              height: 85.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SizedBox(height: 15),
          DetailSectionWidget(
            title: "Destacados", 
            child: _buildCarousel()
          ),
          /* SizedBox(height: 25), */
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategory(
                "Popular",
                Icons.add,
              ),
              _buildCategory(
                "Tiendas",
                Icons.add,
              ),
              _buildCategory(
                "Belleza",
                Icons.add,
              ),
              _buildCategory(
                "Adopción",
                Icons.add,
              ),
            ],
          ), */
          SizedBox(height: 25),
          DetailSectionWidget(
            title: "Cerca de tu ubicación", 
            child: Container(
              height: 320,
              child: ListView(
                padding: EdgeInsets.only(bottom: 10),
                scrollDirection: Axis.horizontal,
                children: [
                  Container()
                  /* AlertWidget(
                    compact: true,
                  ),
                  AlertWidget(
                    compact: true,
                  ), */
                ],
              ),
            )
          )
        ],
      )
    );
  }
}