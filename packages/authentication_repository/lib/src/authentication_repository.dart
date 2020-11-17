import 'dart:async';

import 'package:authentication_repository/src/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthenticationStatus { unknown, loading, authenticated, unauthenticated }

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
      _controller.add(AuthenticationStatus.loading);
      return 'success';
    } catch (e) {
      print('error: $e');
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

  void dispose() => _controller.close();
}
