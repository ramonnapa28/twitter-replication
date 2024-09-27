import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserService {
  late List data;

  Future<void> fetchAllUsers() async {
    final response = await http.get(Uri.parse('$HOST/api/v1/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
