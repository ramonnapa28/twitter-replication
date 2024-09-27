import 'dart:convert';
import 'package:http/http.dart';

class ProductService {
  late List data;

  Future<void> fetchAllProducts() async {
    Response response = await get(
        Uri.parse('https://freetestapi.com/api/v1/products'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
