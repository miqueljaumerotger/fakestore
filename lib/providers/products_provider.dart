import 'package:fakestore/models/models.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  final String _baseUrl = 'fakestoreapi.com';

  List<ProductsList> onDisplayProducts = [];
  List<ProductsList> electronicsProducts = [];
  bool isLoading = true;

  ProductsProvider() {
    print('Products Provider Initialized');
    getOnDisplayProducts();
    getOnElectronics();
  }

  // Obtener productos de categorías específicas (joyería, ropa de hombre y mujer)
  getOnDisplayProducts() async {
    print('Fetching display products');
    var url = Uri.https(_baseUrl, '/products');

    final result = await http.get(url);

    if (result.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(result.body);

      onDisplayProducts = jsonList.map((item) {
        return ProductsList.fromMap(item);
      }).where((product) {
        return product.category == Category.JEWELERY ||
            product.category == Category.MEN_S_CLOTHING ||
            product.category == Category.WOMEN_S_CLOTHING;
      }).toList();

      isLoading = false; // Datos cargados
      notifyListeners();
    } else {
      print('Request failed with status: ${result.statusCode}');
    }
  }

  // Obtener productos electrónicos
  getOnElectronics() async {
    print('Fetching electronics products');
    var url = Uri.https(_baseUrl, '/products/category/electronics');

    final result = await http.get(url);

    if (result.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(result.body);

      electronicsProducts = jsonList.map((item) => ProductsList.fromMap(item)).toList();

      notifyListeners(); // Notificar cambios
    } else {
      print('Request failed with status: ${result.statusCode}');
    }
  }
}
