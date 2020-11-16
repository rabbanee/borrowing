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
    await Future<void>.delayed(const Duration(seconds: 1));
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

    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );x
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
