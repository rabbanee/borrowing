part of 'view_models.dart';

Future requestBorrow({necessity, teacherInCharge, borrowDate, reason}) async {
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: 'token');
  print(borrowDate.value);
  try {
    http.Response result = await http.post(
      Uri.parse('https://pinjaman-api.herokuapp.com/api/request-borrow'),
      headers: {"Accept": "application/json", 'Authorization': 'Bearer $token'},
      body: {
        "necessity": necessity,
        "teacher_in_charge": teacherInCharge.value,
        "borrow_date": borrowDate.value,
        "reason": reason.value,
      },
    );
    if (result.statusCode == 200 || result.statusCode == 201) {
      print('Success to request loan: ${result.body}');
      return true;
    } else {
      print('Failed to request loan: ${result.body}');
      return false;
    }
  } catch (e) {
    print('Failed to request loan: $e');
    return false;
  }
}

Future getHistoryLoaning({perPage = 5, page = 1}) async {
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: 'token');
  try {
    http.Response result = await http.get(
        Uri.parse(
            'https://pinjaman-api.herokuapp.com/api/history-borrow/$perPage?page=$page'),
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
