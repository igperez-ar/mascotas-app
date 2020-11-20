import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class SignInForm extends StatefulWidget {

  final AutenticacionBloc autenticacionBloc;
  final Function onSubmit;

  const SignInForm({
    Key key,
    @required this.autenticacionBloc,
    this.onSubmit
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AutenticacionBloc get _autenticationBloc => widget.autenticacionBloc;

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
                hintText: 'Usuario',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              InputValidatedWidget(
                controller: _passwordController,
                hintText: 'Contraseña',
                icon: Icons.lock,
                password: true,
              ),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  if (state is! AutenticacionLoading && _formKey.currentState.validate()) {
                    _autenticationBloc.add(AutenticacionLoggedIn(
                      email: _emailController.text,
                      password: _passwordController.text
                    ));
                    if (widget.onSubmit != null)
                      widget.onSubmit();
                  }
                },
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  /* width: 150, */
                  height: 50,
                  alignment: Alignment.center,
                  child: state is AutenticacionLoading 
                    ? Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white, 
                          strokeWidth: 3
                        )
                      ) 
                    : Text('Ingresar', style: TextStyle(fontSize: 16))
                )
              ),
            ],
          );
        }
      )
    );
  }
}