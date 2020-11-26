import 'dart:async';
/* import 'dart:html'; */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/providers/location_provider.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/screens/forms/create_alert_form.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class CreateAlertScreen extends StatefulWidget {
  @override
  _CreateAlertScreenState createState() => _CreateAlertScreenState();
}

class _CreateAlertScreenState extends State<CreateAlertScreen> {
  /* AutenticacionBloc _autenticacionBloc; */
  TextEditingController _descriptionController = TextEditingController();
  List<File> _images = []; 
  AlertType _alertType;

  @override
  void initState() {
    super.initState();

    /* _autenticacionBloc = BlocProvider.of<AutenticacionBloc>(context); */
  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            Mutation(
              options: MutationOptions(
                documentNode: gql(QueryAlert.addAlert),
              ),
              builder: (RunMutation addAlert, QueryResult result) {
                
                return BlocBuilder<AutenticacionBloc,AutenticacionState>(
                  builder: (context, state) {
                    
                    if (state is AutenticacionAuthenticated) {

                      return IconButton(
                        icon: Icon(Icons.check, size: 30.0,),
                        onPressed: () async {
                          Position _position = await LocationProvider().getCurrentPosition();

                          if (true) {

                            addAlert({
                              "description": _descriptionController.text,
                              "lat": _position.latitude,
                              "lng": _position.longitude,
                              "userId": state.usuario.id,
                              "typeId": _alertType.id,
                              "photos": _images.map((image) => MultipartFile.fromBytes(
                                "photo",
                                image.readAsBytesSync(),
                                filename: "${DateTime.now()}.jpg",
                                contentType: MediaType("image", "jpg"),
                              )).toList()
                            });
                            
                            Navigator.pop(context);
                          }
                        }
                      );
                    }

                    return CircularProgressIndicator();
                  },
                );
              },
            )
          ],
        ),
        body: Query(
          options: QueryOptions(
            documentNode: gql(QueryAlertType.getAll),
          ),
          builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text("Error");
            }

            if (result.loading) {
              return Center(
                child: CircularProgressIndicator()
              );
            }

            List<AlertType> alertTypes = result.data["urbanAlertTypes"]
              .map<AlertType>((e) => AlertType.fromJson(e))
              .toList();

            if (alertTypes.isEmpty) {
              return Text("Vacío");
            } 
            
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Descripción", 
                  child: Container(
                    constraints: BoxConstraints(minHeight: 100, maxHeight: 300),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
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
                            controller: _descriptionController,
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
                  child: DropdownWidget(
                    items: alertTypes,
                    onChange: (newValue) {
                      setState(() {
                        _alertType = newValue;
                      });
                    }
                  )
                ),
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Lugar",
                  child: Row(
                    children: [
                      Text("Por ahora ubicación local")
                    ],
                  )
                ),
                SizedBox(height: 10),
                ImagePickerWidget(
                  imagesSelected: _images
                ),
              ],
            );
          }
        )
      )
    );
  }
}