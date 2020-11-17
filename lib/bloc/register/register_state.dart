part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.cPassword = const Password.pure(),
    this.role = '',
    this.parentEmail = const Email.pure(),
  });

  final FormzStatus status;
  final Name name;
  final Email email;
  final Password password;
  final Password cPassword;
  final String role;
  final Email parentEmail;

  RegisterState copyWith({
    FormzStatus status,
    Name name,
    Email email,
    Password password,
    Password cPassword,
    String role,
    Email parentEmail,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      cPassword: cPassword ?? this.cPassword,
      role: role ?? this.role,
      parentEmail: parentEmail ?? this.parentEmail,
    );
  }

  @override
  List<Object> get props => [status, name, email, password, cPassword, role, parentEmail];
}
