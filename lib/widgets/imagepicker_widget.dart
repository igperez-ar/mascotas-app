import 'dart:io';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mascotas_app/widgets/widgets.dart';
import 'package:mascotas_app/models/models.dart';


class ImagePickerWidget extends StatefulWidget {
  /* final int id;
  final Establecimiento type; */
  final List<File> imagesSelected;

  const ImagePickerWidget({
    Key key, 
    this.imagesSelected
    /* @required this.id,
    @required this.type */
  }): super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> with TickerProviderStateMixin {
  var squareRotation = 0.0;
  AnimationController _controllerA;
  bool _deleting = false;
  List<File> _toDelete = [];

  List<File> _images;
  final picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _controllerA = AnimationController(
      vsync: this,
      value: 0.0,
      lowerBound: -0.05,
      upperBound: 0.05,
      duration: Duration(milliseconds: 130));
    _controllerA.addListener(() {
      setState(() {
        squareRotation = _controllerA.value;
      });
    });
    super.initState();
    _images = widget.imagesSelected;
  }

  @override
  void dispose() {
    _controllerA.dispose();
    super.dispose();
  }

  void _changeDeleting({bool value}) {
    setState(() {
      _deleting = value ?? !_deleting;
    });

    if (_deleting) {
      _controllerA.repeat(reverse: true);
    } else {
      _controllerA.animateTo(0.0);
      setState(() {
        _toDelete.clear();
      });
    }
  }

  Future _getCameraImage() async {
    _changeDeleting(value: false);

    final pickedFile = await picker.getImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      GallerySaver.saveImage(pickedFile.path);

      setState(() {
        _images.add(File(pickedFile.path));
      });

      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients)
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
      });
    }
  }

  Future _getGalleryImage() async {
    _changeDeleting(value: false);

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null){
      setState(() {
        _images.add(File(pickedFile.path));
      });

      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients)
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
      });
    }
  }

  Widget _getImages() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _deleting
          ? Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_toDelete.length} elementos seleccionados.'),
                  FlatButton(
                    onPressed: () {
                      _images.removeWhere((element) => _toDelete.contains(element));
                      _changeDeleting(value: false);
                    }, 
                    child: Text('Confirmar'), 
                    textColor: Colors.teal[400]
                  )
                ]
              )
            )
          : Container(),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            shrinkWrap: true,
            controller: _scrollController,
            children:
              _images.map<Widget>((image) { 
                final bool _selected = _toDelete.contains(image);

                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (_deleting) {
                        if (_selected) {
                          _toDelete.remove(image);
                        } else {
                          _toDelete.add(image);
                        }
                      } 
                    },
                    child: Transform.rotate(
                      angle: squareRotation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration( 
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(image),
                            fit: BoxFit.cover
                          ),
                        ),
                        child: _selected
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.red[300].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            )
                          : Container()
                      )
                    )
                  )
                );
              }
            ).toList()
          )
        )
      ],
    );
  }

  Widget _getEmptyWidget(context) {
    final _width = MediaQuery.of(context).size.width;
    
    return Container(
      height: _width * 0.42,
      width: _width,
      child: DashedContainer(
        dashColor: Colors.grey[500], 
        strokeWidth: 2,
        dashedLength: 11,
        blankLength: 10,
        borderRadius: 20,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.photo_library, size: 50, color: Colors.grey[600],),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text('no hay imágenes seleccionadas'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {

    return DetailSectionWidget(
      title: 'Imágenes',
      actions: [
        {'icon': Icons.camera_alt,
        'onPressed': () => _getCameraImage(),
        },
        {'icon': Icons.photo_library,
        'onPressed': () => _getGalleryImage(),
        },
        _images.isNotEmpty 
          ? {'icon': _deleting ? Icons.delete_forever : Icons.delete,
            'onPressed': () => _changeDeleting(),
            }
          : {}
      ],
      child: ( _images.isNotEmpty 
        ? _getImages()
        : _getEmptyWidget(context)
      )
    );
  }
}