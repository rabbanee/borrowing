import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

class UserRepository {
  final storage = new FlutterSecureStorage();
  User _user;

  Future<User> getUser() async {
    var response;
    String token = await storage.read(key: 'token');
    if (_user != null) return _user;
    try {
      response = await http.get(
          'https://pinjaman-api.herokuapp.com/api/user/detail',
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {}
    _user = userFromJson(response.body);
    print('response from user repo: ${_user.data}');
    return _user;
    // return Future.delayed(
    //     const Duration(milliseconds: 300), () => _user = User(Uuid().v4()));
  }
}
