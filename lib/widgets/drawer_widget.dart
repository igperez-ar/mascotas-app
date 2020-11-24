import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            /* padding: EdgeInsets.only(left: 5), */
            decoration: BoxDecoration(
              color: Colors.red[300],
            )
          ),
          /* Container(
            alignment: Alignment(1, 1.2),
            padding: EdgeInsets.only(left: 20),
            child: Image.asset('assets/images/drawer_dog.png')
          ), */
          Container(
            color: Colors.black.withOpacity(0.2)
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('Ignacio Perez', style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    )
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  /* color: Colors.blue, */
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        spreadRadius: 2,
                        offset: Offset(2,2),
                      )
                    ]
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home, size: 30, color: Colors.red[300]),
                      SizedBox(width: 15),
                      Text('Inicio', style: TextStyle(
                        color: Colors.red[300],
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Row(
                  children: [
                    Icon(Icons.pets, size: 30, color: Colors.white),
                    SizedBox(width: 15),
                    Text('Adopción', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      ),
                    ),
                  ]
                ),),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Row(
                  children: [
                    Icon(Icons.nature_people, size: 30, color: Colors.white),
                    SizedBox(width: 15),
                    Text('Puntos de interés', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      ),
                    ),
                  ]
                ),),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Row(
                  children: [
                    Icon(Icons.error, size: 30, color: Colors.white),
                    SizedBox(width: 15),
                    Text('Alertas', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      ),
                    ),
                  ]
                ),),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Row(
                  children: [
                    Icon(Icons.person, size: 30, color: Colors.white),
                    SizedBox(width: 15),
                    Text('Perfil', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      ),
                    ),
                  ]
                ),),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
          /* Container(
            padding: EdgeInsets.only(left: 10, bottom: 30),
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Icon(Icons.settings, size: 40, color: Colors.white),
                SizedBox(width: 15),
                Text('Configuración', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                Text('|', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                Text('Salir', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ],
            )
          ) */
          /* Container(
          /* padding: EdgeInsets.only(left: 5), */
          decoration: BoxDecoration(
            color: Colors.red[300],
            image: DecorationImage(
              alignment: Alignment(-1, 1.1),
              image: AssetImage('assets/images/drawer_dog.png')
            )
          ), */
        ],
      )
        /* child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Container(),
                  Text('Ignacio Perez'),
                ],
              ),
              decoration: BoxDecoration(
                /* color: Colors.blue, */
              ),
            ),
            ListTile(
              title: Text('Adopción'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Puntos de interés'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Alertas'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Perfil'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ) */
    );
  }
}