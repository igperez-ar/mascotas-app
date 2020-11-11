import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/models/models.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class CreateAlertForm extends StatefulWidget {
  final _CreateAlertFormState state = _CreateAlertFormState();
  final AutenticacionBloc autenticacionBloc;

  CreateAlertForm({
    Key key,
    @required this.autenticacionBloc
  }) : super(key: key);

  @override
  _CreateAlertFormState createState() {
    return this.state;
  }
}

class _CreateAlertFormState extends State<CreateAlertForm> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String image;
  Usuario user;

  final _formKey = GlobalKey<FormState>();

  AutenticacionBloc get _autenticationBloc => widget.autenticacionBloc;

  @override 
  void initState() {
    super.initState();
    
    if (_autenticationBloc.state is AutenticacionAuthenticated) {
      user = (_autenticationBloc.state as AutenticacionAuthenticated).usuario;
      image = user.foto;
    } 
    /* _passwordController.addListener(() {
      if (!_showConfirm && _passwordController.text.isNotEmpty) {
        setState(() {
          _showConfirm = true;
        });
      }
    }); */
  }

  void validateForm() async {
    final state = _autenticationBloc.state;
    FocusScope.of(context).unfocus();

    if (state is AutenticacionAuthenticated && _formKey.currentState.validate()) {
      Usuario oldUser = state.usuario;
      Usuario newUser = oldUser.copyWith(
        nombre: _nameController.text,
        descripcion: _descriptionController.text,
        foto: image,
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text
      );
      
      _autenticationBloc.add(AutenticacionUpdate(
        username: oldUser.username,
        newUser: newUser,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {

          return Column(
            children: [
              InputValidatedWidget(
                controller: _usernameController,
                initialValue: user?.username,
                hintText: 'Usuario',
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _nameController,
                hintText: 'Nombre completo',
                initialValue: user?.nombre,
                textCapitalization: TextCapitalization.words,
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _descriptionController,
                hintText: 'Descripción',
                initialValue: user?.descripcion,
                textCapitalization: TextCapitalization.sentences,
                max: 100,
                optional: true,
                icon: Icons.description,
              ),
              InputValidatedWidget(
                controller: _emailController,
                hintText: 'Email',
                initialValue: user?.email,
                email: true,
                icon: Icons.email,
              ),
              InputValidatedWidget(
                controller: _passwordController,
                hintText: 'Contraseña',
                initialValue: user?.password,
                password: true,
                icon: Icons.lock,
              ),
              /* Visibility(
                visible: _showConfirm,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: _showConfirm ? 1.0 : 0.0,
                  child: InputValidatedWidget(
                    controller: _password2Controller,
                    hintText: 'Confirmar contraseña',
                    icon: Icons.lock,
                    password: true,
                    validPassword: _passwordController,
                  )
                )
              ), */
              SizedBox(height: 40),
              /* RaisedButton(
                onPressed: validateForm,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: (state is AutenticacionLoading
                    ? Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white, 
                          strokeWidth: 3
                        )
                      )
                    : Text('Editar', style: TextStyle(fontSize: 16))
                  )
                )
              ), */
              /* RaisedButton(
                onPressed: () {
                  /* _autenticacionBloc.add(AutenticacionLoggedOut());
                  Navigator.pop(context); */
                }, 
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text('Cambiar contraseña', style: TextStyle(fontSize: 16),)
                )
              ), */
            ]
            /* )
          }

          return Center(child: CircularProgressIndicator());
        } */
      );}
    ));
  }
}