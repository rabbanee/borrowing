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
    String user = await storage.read(key: 'user');
    if (user != null) {
      _user = userFromJson(user);
      return _user;
    }
    try {
      response = await http.get(
          'https://pinjaman-api.herokuapp.com/api/user/detail',
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      print('error getting user: $e');
      return _user;
    }
    _user = userFromJson(response.body);
    await storage.write(key: 'user', value: response.body.toString());
    return _user;
  }
}
