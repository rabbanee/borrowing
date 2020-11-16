import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

class UserRepository {
  final storage = new FlutterSecureStorage();
  User _user;

  Future<User> getUser() async {
    String token = await storage.read(key: 'token');
    print(token);
    if (_user != null) return _user;
    try {
      // var reponse = await htt[]
    } catch (e) {}
    return Future.delayed(
        const Duration(milliseconds: 300), () => _user = User(Uuid().v4()));
  }
}
