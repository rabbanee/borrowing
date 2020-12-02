part of 'view_models.dart';

Future getUsersByRole({role}) async {
  try {
    http.Response result =
        await http.get('https://pinjaman-api.herokuapp.com/api/users/$role');
    if (result.statusCode == 200) {
      final data = usersFromJson(result.body);
      return data;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
