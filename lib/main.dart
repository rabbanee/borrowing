import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:borrowing/app.dart';
import 'package:flutter/widgets.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  runApp(App(
    authenticationRepository: AuthenticationRepository(
      userRepository: UserRepository(),
    ),
  ));
}
