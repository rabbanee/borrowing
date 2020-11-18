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
    } catch (e) {
      print('error getting user: $e');
      return _user;
    }
    print(response);
    _user = userFromJson(response.body);
    return _user;
  }
}
