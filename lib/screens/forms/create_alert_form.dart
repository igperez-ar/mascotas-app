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

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
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
      image = user.image;
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
        email: _emailController.text,
        name: _nameController.text,
        image: image,
      );
      
      _autenticationBloc.add(AutenticacionUpdate(
        email: oldUser.email,
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
                controller: _emailController,
                initialValue: user?.email,
                hintText: 'Usuario',
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _nameController,
                hintText: 'Nombre completo',
                initialValue: user?.name,
                textCapitalization: TextCapitalization.words,
                icon: Icons.person,
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