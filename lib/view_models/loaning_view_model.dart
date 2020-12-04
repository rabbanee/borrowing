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

Future returnBorrowing({image, description, borrowingId}) async {
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: 'token');
  Response response;
  Dio dio = new Dio();
  String fileName = image.path.split('/').last;

  FormData formData = new FormData.fromMap({
    "description": description,
    "image": await MultipartFile.fromFile(image.path, filename: fileName),
  });
  dio.options.headers["Authorization"] = "Bearer $token";
  try {
    response = await dio.post(
        "https://pinjaman-api.herokuapp.com/api/assignment/$borrowingId",
        data: formData);
    print(response);
    return true;
  } catch (e) {
    if (e is DioError) {
      //handle DioError here by error type or by error code
      print('error dio: ${e.response.data}');
      return false;
    } else {
      // print(e.message);
      return false;
    }
    // print('error: ${e.toString()}');
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
