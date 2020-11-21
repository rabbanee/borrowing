part of 'view_models.dart';

Future getHistoryLoaning({perPage = 5, page = 1}) async {
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: 'token');
  try {
    http.Response result = await http.get(
        Uri.parse(
            'https://pinjaman-api.herokuapp.com/api/history-borrow/$perPage'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        });
    if (result.statusCode == 200) {
      print('Success get data');
      final data = loaningHistoryFromJson(result.body);
      return data;
    } else {
      print('Failed to get data');
      return null;
    }
  } catch (e) {}
}
