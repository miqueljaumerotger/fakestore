import 'package:fakestore/models/models.dart';
import 'widgets.dart';

/**
 * Widget `ProductPoster`: Aquest widget es fa servir per mostrar una vista prèvia de cada producte en una petita targeta. 
 * Cada targeta conté la imatge del producte i el seu títol, i és interactiva. En prémer la targeta, l'usuari pot veure els detalls complets del producte.
 *
 * Components principals:
 *
 * 1. **Classe `ProductPoster`**:
 *    - Aquest widget mostra una imatge en miniatura del producte i el seu títol dins d'un contenidor de dimensions fixades (130x190).
 *    - El títol del producte és mostrat en un text limitat a 4 línies amb punts suspensius si el text excedeix aquest límit.
 *    - En prémer la imatge o el títol del producte, es navega a la pantalla de detalls del producte, passant l'objecte `product` com a argument.
 *    - Utilitza `FadeInImage` per carregar la imatge del producte amb una imatge de càrrega per evitar que es mostri una imatge buida.
 *
 * 2. **Interactivitat**:
 *    - El producte és clicable gràcies a `GestureDetector`. Quan l'usuari prem sobre la imatge del producte, es fa una navegació a la pantalla de detalls (`'details'`), passant l'objecte `product` com a argument.
 *    - La imatge del producte es carrega de manera asíncrona amb `FadeInImage`, i s'hi proporciona una imatge de càrrega fins que la imatge real estigui disponible.
 *
 * 3. **Disseny**:
 *    - El producte es mostra en una columna, amb la imatge a la part superior i el títol a sota.
 *    - El títol es limita a 4 línies amb l'ús de `TextOverflow.ellipsis`, de manera que si el títol és massa llarg, es mostra amb punts suspensius.
 *    - La imatge del producte té una forma arrodonida gràcies a `ClipRRect` amb un radi de 20.
 *
 * 4. **Estilització**:
 *    - Es fa servir un estil de text petit (fontSize: 11) per al títol del producte, amb centrament i límit de línies.
 *    - El component també utilitza un margí entre els productes per evitar que estiguin massa a prop els uns dels altres.
 *
 * Funcionalitats destacades:
 * - Cada targeta de producte és interactiva i permet l'accés als detalls del producte.
 * - El disseny és compacte, amb una mida fixa per als elements de cada producte.
 * - La càrrega d'imatges es realitza de manera eficient utilitzant una imatge de càrrega fins que la imatge real es carrega completament.
 */

class ProductPoster extends StatelessWidget {
  final ProductsList product;

  const ProductPoster({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: product),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(product.image ?? 'https://i.sstatic.net/GNhxO.png'),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.title,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
          )
        ],
      ),
    );
  }
}