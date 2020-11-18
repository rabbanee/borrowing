part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterCPasswordChanged extends RegisterEvent {
  const RegisterCPasswordChanged(this.cPassword);

  final String cPassword;

  @override
  List<Object> get props => [cPassword];
}

class RegisterRoleChanged extends RegisterEvent {
  const RegisterRoleChanged(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

class RegisterParentEmailChanged extends RegisterEvent {
  const RegisterParentEmailChanged(this.parentEmail);

  final String parentEmail;

  @override
  List<Object> get props => [parentEmail];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
