import 'package:fakestore/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:fakestore/widgets/widgets.dart';
import 'package:provider/provider.dart';

/**
 * Pantalla Principal de Fakestore: Aquesta pantalla mostra els productes a la pantalla inicial de l'aplicació,
 * incloent-hi un títol de l'aplicació, un botó de cerca i una llista de productes en dues categories diferents.
 * La pantalla utilitza `SingleChildScrollView` per permetre el desplaçament dels productes i una estructura de 
 * carregament dinàmic.
 * 
 * Components principals:
 * 
 * 1. **Classe `HomeScreen`**:
 *    - Aquesta és la pantalla principal de l'aplicació que es carrega quan es llança l'aplicació.
 *    - Mostra un `AppBar` amb el títol de l'aplicació i un botó de cerca. El botó de cerca actualment no té funcionalitat definida.
 *    - El cos de la pantalla es compon de dos tipus de productes que es carreguen de manera dinàmica: els productes generals i els productes electrònics.
 * 
 * 2. **Carregament de Dades**:
 *    - Si les dades estan carregant (`isLoading`), es mostra un `CircularProgressIndicator` per indicar a l'usuari que les dades s'estan recuperant.
 *    - Un cop les dades es carreguen, es mostra una llista de productes. Es fa servir `CardSwiper` per mostrar els productes generals i `ProductSlider` per mostrar els productes electrònics. 
 *    - `productsProvider.onDisplayProducts` i `productsProvider.electronicsProducts` són els dos tipus de llistes de productes gestionades pel proveïdor de dades `ProductsProvider`.
 *
 * Funcionalitats destacades:
 * - La pantalla fa ús de `SingleChildScrollView` per permetre al contingut desplaçar-se quan sigui necessari.
 * - La càrrega dels productes es gestiona dinàmicament a través de `isLoading` i el `CircularProgressIndicator`.
 * - Es fa ús de widgets personalitzats com `CardSwiper` i `ProductSlider` per presentar els productes de manera visualment atractiva.
 * - El botó de cerca està present a la barra d'eines, però actualment no té implementació funcional.
 */

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fakestore'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (productsProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: [
                  CardSwiper(products: productsProvider.onDisplayProducts),
                  ProductSlider(products: productsProvider.electronicsProducts),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
