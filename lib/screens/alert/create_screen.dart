import 'dart:async';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
  TextEditingController _textEditingController = TextEditingController();
  CreateAlertForm _createForm;
  int stateId;

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
    final _width = MediaQuery.of(context).size.width;

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
                  child: Container(
                    constraints: BoxConstraints(minHeight: 100, maxHeight: 300),
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
                              /* setState(() {
                                _isDisabled = _textEditingController.text.isEmpty;
                              }); */
                            },
                            decoration: InputDecoration(
                              hintText: 'Describe la situación',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            minLines: 5,
                            maxLines: null,
                          ),
                        )
                      ]
                    )
                  ),
                ),
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Estado de la mascota", 
                  child: Container()/* Query(
                    options: QueryOptions(
                      documentNode: gql(QueryGrupo.getOne),
                      variables: {
                        'grupo': widget.grupoId
                      },
                    ),
                    builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {

                      return DropdownButton<int>(
                        onChanged: (int newValue) {
                          setState(() {
                            stateId = newValue;
                          });
                        },
                        items: []
                      ); 
                    },
                  ), */
                ),
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Lugar", 
                  child: Row(
                    children: [
                      
                    ],
                  )
                ),
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Imágenes", 
                  child: Container(
                  width: _width,
                  child: DashedContainer(
                      dashColor: Colors.grey[500], 
                      strokeWidth: 2,
                      dashedLength: 10,
                      blankLength: 9,
                      borderRadius: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.photo_library, size: 50, color: Colors.grey[600]),
                            SizedBox(height: 10),
                            Text('Seleccionar imágenes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  )
                ),
              ],
            )
          );
        },
      )
    );
  }
}