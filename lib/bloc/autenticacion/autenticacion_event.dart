part of 'autenticacion_bloc.dart';

abstract class AutenticacionEvent extends Equatable {
  const AutenticacionEvent();
}

class AutenticacionLoggedIn extends AutenticacionEvent {
  final String email;
  final String password; 

  const AutenticacionLoggedIn({
    this.email,
    this.password
  });

  @override
  List<Object> get props => [this.email, this.password];
}

class AutenticacionRegister extends AutenticacionEvent {
  final String name;
  final String email;
  final String password;

  const AutenticacionRegister({
    this.name,
    this.password,
    this.email
  });

  @override
  List<Object> get props => [this.name, this.password, this.email];
}

class AutenticacionUpdate extends AutenticacionEvent {
  final String email;
  final Usuario newUser;

  const AutenticacionUpdate({
    this.email,
    this.newUser
  });

  @override
  List<Object> get props => [this.email, this.newUser];
}

class AutenticacionLoggedOut extends AutenticacionEvent {
  const AutenticacionLoggedOut();

  @override
  List<Object> get props => [];
}
