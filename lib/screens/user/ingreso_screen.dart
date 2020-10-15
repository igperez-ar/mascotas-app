import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class IngresoScreen extends StatefulWidget {
  final int selectedTab;

  const IngresoScreen({
    Key key,
    this.selectedTab = 1
  }) : super(key: key);

  @override
  _IngresoScreenState createState() => _IngresoScreenState();
}

class _IngresoScreenState extends State<IngresoScreen> {
  AutenticacionBloc _autenticacionBloc;
  StreamSubscription _autenticacionListener;
  int _selectedTab;

  @override 
  void initState() {
    super.initState();

    _autenticacionBloc = BlocProvider.of<AutenticacionBloc>(context);
    _selectedTab = widget.selectedTab;
  }

  @override
  void dispose() {
    if (_autenticacionListener != null)
      _autenticacionListener.cancel();
    super.dispose();
  }

  Widget _renderSignup() {

    return BlocBuilder<AutenticacionBloc,AutenticacionState>(
      builder: (context, state) {

        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 50, bottom: 30),
              child: Text('Crea tu cuenta',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),  
              ),
            ),
            SignUpForm(
              autenticacionBloc: _autenticacionBloc
            ),
            /* SizedBox(height: 10),
            GestureDetector(
              onTap: () => setState(() {
                _selectedTab = 1;
              }),
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ya tienes una cuenta?', 
                      style: TextStyle(
                        color: Colors.grey[600]
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text('Inicia sesión', 
                      style: TextStyle(
                        color: Colors.blue[800]
                      ),
                    ),
                  ],
                )
              )
            ) */
          ],
        );
      },
    );
  }

  Widget _renderSignin(BuildContext context) {

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 50, bottom: 30),
          child: Text('Ingresa en tu cuenta',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 22,
              fontWeight: FontWeight.w600
            ),  
          ),
        ),
        SignInForm(
          autenticacionBloc: _autenticacionBloc,
          onSubmit: () {
            _autenticacionListener = _autenticacionBloc.listen((state) {
              if (state is AutenticacionUnauthenticated) {
                SnackBarWidget.show(context, state.error, SnackType.danger);
              }
            });
          },
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () => setState(() {
            _selectedTab = 0;
          }),
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No tienes una cuenta?', 
                  style: TextStyle(
                    color: Colors.grey[600]
                  ),
                ),
                SizedBox(width: 5),
                Text('Registrate', 
                  style: TextStyle(
                    color: Colors.red[300],
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            )
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        /* title: Text(_selectedTab == 1 ? 'Iniciar sesión' : 'Registrarse', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, */
        elevation: 0,
        backgroundColor: Colors.grey[200],
        leading: (_selectedTab == 0
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.red[300], size: 30,),
              onPressed: () => setState(() {
                _selectedTab = 1;
              }),
            )
          : null
        ),
      ),
      body: Center(
        child: BlocBuilder<AutenticacionBloc, AutenticacionState>(
          builder: (context, state) {
              return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: _selectedTab == 1 ? null : 0,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: SvgPicture.asset(
                      'assets/images/undraw_sign_in.svg',
                      height: _height * 0.15,
                    )
                  ),
                  Container(
                    height: _selectedTab == 0 ? null : 0,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: SvgPicture.asset(
                      'assets/images/undraw_register.svg',
                      height: _height * 0.15,
                    )
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Builder(
                      builder: (context) {
                        if (_selectedTab == 0) 
                          return _renderSignup();
                          return _renderSignin(context);
                      },
                    )
                  )
                ]
              )
            );
          },
        )
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}