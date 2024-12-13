import 'package:fakestore/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/**
 * Aquesta classe `ProductsProvider` gestiona la recuperació i el manteniment dels productes des d'una API externa
 * utilitzant el paquet HTTP. A més, implementa l'arquitectura de notificació de canvis mitjançant `ChangeNotifier` 
 * per actualitzar la interfície d'usuari quan les dades canviïn.
 *
 * Components principals:
 *
 * 1. **Atributs de la classe**:
 *    - `_baseUrl`: URL base de l'API que s'utilitza per a les peticions HTTP.
 *    - `onDisplayProducts`: Llista dels productes que es mostren en la interfície (els productes de categories específiques).
 *    - `electronicsProducts`: Llista dels productes electrònics recuperats de l'API.
 *    - `isLoading`: Boolean que indica si les dades estan sent carregades.
 *
 * 2. **Constructor**:
 *    - El constructor inicialitza el proveïdor i crida les funcions per obtenir els productes a mostrar (`getOnDisplayProducts`) 
 *      i els productes electrònics (`getOnElectronics`).
 *
 * 3. **Mètode `getOnDisplayProducts`**:
 *    - Fa una petició HTTP a l'API per obtenir la llista de productes generals.
 *    - Filtra els productes per categories específiques: joieria, roba d'home i roba de dona.
 *    - Un cop es recuperen els productes, es marquen com carregats (`isLoading = false`) i es notifiquen els canvis amb `notifyListeners()`.
 *    - Si la petició no és correcta (statusCode diferent de 200), es mostra un missatge d'error a la consola.
 *
 * 4. **Mètode `getOnElectronics`**:
 *    - Fa una petició HTTP per obtenir els productes de la categoria electrònica.
 *    - Un cop es recuperen els productes, es guarden a la llista `electronicsProducts` i es notifiquen els canvis amb `notifyListeners()`.
 *    - Si la petició no és correcta (statusCode diferent de 200), es mostra un missatge d'error a la consola.
 *
 * Funcionalitats destacades:
 * - Recuperació de dades de productes d'una API externa (fakestoreapi.com).
 * - Filtratge de productes per categories específiques (joieria, roba d'home i dona).
 * - Actualització de l'estat i notificació als oients per refrescar la interfície d'usuari.
 */

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

  // Obtenir productes de categories específiques
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

      isLoading = false; // Dades carregades
      notifyListeners();
    } else {
      print('Request failed with status: ${result.statusCode}');
    }
  }

  // Obtenir productes electrònics
  getOnElectronics() async {
    print('Fetching electronics products');
    var url = Uri.https(_baseUrl, '/products/category/electronics');

    final result = await http.get(url);

    if (result.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(result.body);

      electronicsProducts = jsonList.map((item) => ProductsList.fromMap(item)).toList();

      notifyListeners();
    } else {
      print('Request failed with status: ${result.statusCode}');
    }
  }
}
