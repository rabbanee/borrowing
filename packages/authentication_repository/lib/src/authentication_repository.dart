import 'dart:async';

import 'package:authentication_repository/src/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  authenticatedFailure
}

class AuthenticationRepository {
  AuthenticationRepository({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  UserRepository _userRepository;
  final _controller = StreamController<AuthenticationStatus>();
  final storage = new FlutterSecureStorage();
  String token;

  Stream<AuthenticationStatus> get status async* {
    token = await storage.read(key: 'token');
    if (token != null) {
      yield AuthenticationStatus.authenticated;
      yield* _controller.stream;
      return;
    }
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<String> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);

    try {
      var response =
          await http.post('https://pinjaman-api.herokuapp.com/api/login',
              body: ({
                'email': email,
                'password': password,
              }));
      if (response.statusCode != 200) {
        return 'error';
      }

      token = (tokenFromJson(response.body)).data.token;
      await storage.write(key: 'token', value: token);

      print('ini token: $token');
      final user = await _tryGetUser();
      if (user == null) {
        _controller.add(AuthenticationStatus.unauthenticated);
        return 'error';
      }

      _controller.add(AuthenticationStatus.authenticated);
      return 'success';
    } catch (e) {
      print('error: $e');
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    return 'error';
  }

  Future<User> _tryGetUser() async {
    print('ini repo gais $_userRepository');
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }

  Future<String> register({
    @required String name,
    @required String email,
    @required String password,
    @required String role,
    @required String parentEmail,
  }) async {
    assert(name != null);
    assert(email != null);
    assert(password != null);
    assert(role != null);
    assert(parentEmail != null);

    try {
      print('name: $name, email: $email. parenEmail: $parentEmail');
      var response =
          await http.post('https://pinjaman-api.herokuapp.com/api/register',
              body: ({
                'name': name,
                'email': email,
                'password': password,
                'c_password': password,
                'role': role,
                'parent_email': parentEmail,
              }));
      print('body: ${response.statusCode}');
      if (response.statusCode != 200) {
        return 'error';
      }
      return 'success';
    } catch (e) {
      print(e);
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    return 'error';
  }

  Future<void> logOut() async {
    token = await storage.read(key: 'token');
    print('masuk');
    try {
      var response =
          await http.get('https://pinjaman-api.herokuapp.com/api/logout',
              headers: ({
                'Authorization': 'Bearer $token',
              }));
      print('masuk; response code: ${response.statusCode}');
      if (response.statusCode == 200) {
        await storage.delete(key: 'token');
        await storage.delete(key: 'user');
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } catch (e) {
      print(e);
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  Future<String> resetPassword({
    @required String email,
  }) async {
    assert(email != null);
    try {
      var response = await http.post(
          'https://pinjaman-api.herokuapp.com/api/forgot-password',
          body: ({
            'email': email,
          }));
      if (response.statusCode != 200) {
        return 'error';
      }
      return 'success';
    } catch (e) {
      print('error: $e');
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    return 'error';
  }

  void dispose() => _controller.close();
}
