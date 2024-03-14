import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Changed from 'adapters.dart'
import 'package:http/http.dart' as http;
import 'package:shopping_cart/src/utils/constant.dart';

import '../model/products.dart';

class ProductRepository {
  static var client = http.Client();

  Future<List<Product>?> fetchProducts() async {
    var res = await client.get(Uri.parse(BASE_URL));
    if (res.statusCode == 200) {
      return productFromJson(res.body);
    } else {
      return null;
    }
  }

  Future<List<dynamic>> fetchProductsInCartDB() async {
    Box box;
    try {
      box = Hive.box('db');
      return box.get('products') ?? []; // Return an empty list if 'products' key is not found
    } catch (error) {
      box = await Hive.openBox('db');
      //print('Error fetching products from Hive: $error ${StackTrace}');
      return box.get('products') ?? []; // Return an empty list if an error occurs
    }
  }
  void addToDb() async {

  }
  void clearDb() {
    try {
      Hive.deleteBoxFromDisk('db');
    } catch (error) {
      //print(error);
    }
  }
  void saveToDb(List<dynamic> products) async {
    try {
      var box = await Hive.openBox('db');
      await box.put('products', products); // Using add instead of put
    } catch (e) {
      //print('Error saving products to Hive: $e');
    }
  }
}
