import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/providers/location_provider.dart';
import 'package:mascotas_app/queries/queries.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/widgets.dart';

class CreatePetScreen extends StatefulWidget {
  @override
  _CreatePetScreenState createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  List<File> _images = []; 
  Kind _kind;
  Breed _breed;
  String _sex;
  DateTime _birthDate;


  bool _validateData() {

    if (_nameController.text.isEmpty) {
      return false;
    }
    if (_descriptionController.text.isEmpty) {
      return false;
    }
    if (_breed == null) {
      return false;
    }
    if (_sex == null) {
      return false;
    }
    if (_birthDate == null) {
      return false;
    }
    if (_images.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final DateTime dateNow = DateTime.now();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nueva mascota', 
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
                documentNode: gql(QueryPet.addPet),
              ),
              builder: (RunMutation addPet, QueryResult result) {

                if (result.loading) {
                  return CircularProgressIndicator();
                }
                
                return BlocBuilder<AutenticacionBloc,AutenticacionState>(
                  builder: (context, state) {
                    
                    if (state is AutenticacionAuthenticated) {

                      return IconButton(
                        icon: Icon(Icons.check, size: 30.0,),
                        onPressed: () {

                          if (_validateData()) {
                            addPet({
                              "name": _nameController.text,
                              "description": _descriptionController.text,
                              "birthDate": _birthDate.toString().split(" ")[0],
                              "sex": _sex,
                              "breedId": _breed.id,
                              "userId": state.usuario.id,
                              "files": _images.map((image) => MultipartFile.fromBytes(
                                "file",
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
            documentNode: gql(QueryBreed.getAll),
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

            List<Breed> breeds = result.data["breeds"]
              .map<Breed>((e) => Breed.fromJson(e))
              .toList();

            if (breeds.isEmpty) {
              return Text("Vacío");
            } 
            
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Nombre",
                  child: InputValidatedWidget(
                    controller: _nameController,
                    hintText: "¿Cómo se llama?",
                  ),
                ),
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
                              hintText: 'Describe la mascota',
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
                  title: "Especie",
                  child: DropdownWidget(
                    items: breeds.map((e) => e.kind).toSet().toList(),
                    selected: _kind,
                    onChange: (newValue) {
                      setState(() {
                        _kind = newValue;
                        _breed = null;
                      });
                    }
                  )
                ),
                Visibility(
                  visible: _kind != null,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      DetailSectionWidget(
                        title: "Raza",
                        child: (_kind != null
                          ? DropdownWidget(
                              items: breeds.where((e) => e.kind.id == _kind.id),
                              selected: _breed,
                              onChange: (newValue) {
                                setState(() {
                                  _breed = newValue;
                                });
                              }
                            )
                          : Container()
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Sexo",
                  child: DropdownWidget(
                    items: ["Macho", "Hembra"],
                    selected: _sex,
                    onChange: (newValue) {
                      final String sexChar = newValue == "Macho" ? "M" : "F";

                      setState(() {
                        _sex = sexChar;
                      });
                    }
                  )
                ),
                SizedBox(height: 10),
                DetailSectionWidget(
                  title: "Fecha de nacimiento",
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey[400],
                        width: 1
                      )
                    ),
                    child: CalendarDatePicker(
                      onDateChanged: (date) {
                        setState(() {
                          _birthDate = date;
                        });
                      },
                      firstDate: dateNow.subtract(Duration(days: 365*100)),
                      initialDate: _birthDate ?? dateNow,
                      lastDate: dateNow,
                      currentDate: _birthDate,
                    )
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