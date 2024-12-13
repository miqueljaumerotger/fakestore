import 'package:fakestore/models/models.dart';
import 'widgets.dart';

/**
 * Widget `ProductSlider`: Aquest widget es fa servir per mostrar una galeria horitzontal de productes electrònics. 
 * El seu propòsit és presentar els productes de manera visualment atractiva, mostrant una petita vista prèvia de cada producte en una fila desplaçable horitzontalment.
 *
 * Components principals:
 *
 * 1. **Classe `ProductSlider`**:
 *    - Aquest widget utilitza un `ListView.builder` per crear una llista desplaçable horitzontalment de productes.
 *    - Cada element de la llista és un widget `ProductPoster` que mostra una petita vista prèvia de cada producte (imatge i títol).
 *    - El títol de la secció de productes es mostra com "Electronics Products", amb un estil de text en negreta i un tamany de font de 20.
 *    - Si la llista de productes és buida, es mostrarà un missatge indicant que no hi ha productes electrònics disponibles.
 *
 * 2. **Interactivitat**:
 *    - Els productes dins del slider són clicables gràcies al widget `ProductPoster`. Quan l'usuari prem sobre un producte, es redirigeix a la pantalla de detalls del producte corresponent.
 *    - Utilitza `ListView.builder` per crear la vista de manera eficient, ja que només renderitza els productes visibles a la pantalla en un moment donat.
 *
 * 3. **Disseny**:
 *    - El títol de la secció es mostra en un `Text` amb un estil que inclou un tamany de font gran i negreta.
 *    - La secció de productes es mostra en un `Container` amb un altitud de 250, permetent que els productes es mostrin de manera compacta.
 *    - Els productes estan en una llista horitzontal (amb `scrollDirection: Axis.horizontal`) per permetre que l'usuari desplaci lateralment per veure els diferents productes.
 *
 * 4. **Estilització**:
 *    - El títol té un `Padding` amb espai horitzontal per evitar que es posi massa a prop de les vores de l'espai.
 *    - La llista de productes es mostra amb un `SizedBox` entre el títol i els productes, amb un espai de 5 unitats.
 *    - Si no hi ha productes disponibles, es mostra un missatge centralitzat a la pantalla indicant que no hi ha productes electrònics.
 *
 * Funcionalitats destacades:
 * - Desplaçament horitzontal per veure múltiples productes en una fila compacta.
 * - Ús de `ListView.builder` per a la creació eficient de la llista de productes.
 * - Missatge per mostrar quan no hi ha productes disponibles.
 * - Estilització per millorar la llegibilitat i la interacció.
 */

class ProductSlider extends StatelessWidget {
  final List<ProductsList> products;

  const ProductSlider({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No electronics products available.'));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Electronics Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5), // Espai entre el títol i el slider
          Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (_, int index) => ProductPoster(product: products[index]),
            ),
          ),
        ],
      ),
    );
  }
}

