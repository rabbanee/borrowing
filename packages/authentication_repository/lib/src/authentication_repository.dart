import 'dart:async';

import 'package:authentication_repository/src/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
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

  Future<void> logIn({
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
      token = (tokenFromJson(response.body)).data.token;
      await storage.write(key: 'token', value: token);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      print(e);
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> register({
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
      token = (tokenFromJson(response.body)).data.token;
      await storage.write(key: 'token', value: token);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      print(e);
      _controller.add(AuthenticationStatus.unauthenticated);
    }
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

  void dispose() => _controller.close();
}
