import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/screens/forms/create_alert_form.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class CreateAlertScreen extends StatefulWidget {
  @override
  _CreateAlertScreenState createState() => _CreateAlertScreenState();
}

class _CreateAlertScreenState extends State<CreateAlertScreen> {
  bool darkMode;
  AutenticacionBloc _autenticacionBloc;
  StreamSubscription _autenticacionListener;
  CreateAlertForm _createForm;

  @override
  void initState() {
    super.initState();

    _autenticacionBloc = BlocProvider.of<AutenticacionBloc>(context);
    _createForm = CreateAlertForm(autenticacionBloc: _autenticacionBloc);
  }

  @override 
  void dispose() {
    if (_autenticacionListener != null)
      _autenticacionListener.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              title: Text('Nueva alerta', 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 30.0), 
                onPressed: () => Navigator.of(context).pop()
              ),
              actions: [
                BlocBuilder<AutenticacionBloc,AutenticacionState>(
                  builder: (context, state) {
                    
                    if (state is AutenticacionLoading)
                      return Container(
                        width: 57,
                        padding: EdgeInsets.all(15),
                        child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 3.0,)
                      );

                    return IconButton(
                      icon: Icon(Icons.check, size: 30.0,),
                      onPressed: () {
                        _createForm.state.validateForm();
                        _autenticacionListener = _autenticacionBloc.listen((_state) {
                          if (_state is AutenticacionUnauthenticated)
                            SnackBarWidget.show(context, _state.error, SnackType.danger, persistent: true);
                          if (_state is AutenticacionAuthenticated)
                            SnackBarWidget.show(context, 'La información se modificó con éxito.', SnackType.success);
                        });
                      },
                    );
                  },
                )
              ],
            ),
            body: ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Descripción", 
                  child: null
                ),
                DetailSectionWidget(
                  title: "Estado de la mascota", 
                  child: null
                ),
                DetailSectionWidget(
                  title: "Lugar", 
                  child: Row(
                    children: [
                    ],
                  )
                ),
                DetailSectionWidget(
                  title: "Imágenes", 
                  child: null
                ),
              ],
            )/* SingleChildScrollView(
              child: _createForm,
            ), */
          );
        },
      )
    );
  }
}