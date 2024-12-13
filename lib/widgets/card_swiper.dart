import 'package:card_swiper/card_swiper.dart';
import 'package:fakestore/models/models.dart';
import 'widgets.dart';

/**
 * Widget `CardSwiper`: Aquest widget mostra una galeria de productes en forma de cartes utilitzant el paquet `card_swiper`.
 * La galeria utilitza un disseny de pila (stack) per mostrar els productes, amb una transició de desplaçament horizontal.
 * El component es carrega amb productes que es passen com a paràmetre i mostra les imatges de cada producte en una interfície atractiva.
 *
 * Components principals:
 *
 * 1. **Classe `CardSwiper`**:
 *    - Aquest widget es fa servir per mostrar un conjunt de productes en forma de cartes interactives.
 *    - Els productes es passen com una llista de `ProductsList` a través del constructor.
 *    - La interfície permet veure una imatge de cada producte i navegar a una pantalla de detall quan es prem una carta.
 *    - S'utilitza el paquet `card_swiper` per implementar una interfície de desplaçament.
 *
 * 2. **Condició de càrrega de dades**:
 *    - Si la llista de productes està buida (per exemple, mentre es carreguen dades), es mostra un indicador de càrrega (`CircularProgressIndicator`).
 *    - Si els productes estan disponibles, es mostra una galeria de cartes amb les imatges dels productes.
 *
 * 3. **Interactivitat**:
 *    - Cada carta de producte és interactiva i es pot tocar. Quan es prem una carta, es navega a una nova pantalla (detalls del producte) passant el producte seleccionat com a argument a través de la ruta `'details'`.
 *    - La imatge de cada producte es carrega amb `FadeInImage`, mostrant una imatge de càrrega per evitar que es mostrin imatges en blanc mentre es carrega el contingut.
 *
 * 4. **Disseny**:
 *    - El disseny utilitza una alçada i amplada del 50% de la pantalla, ajustant-se a les dimensions de la pantalla (`MediaQuery`).
 *    - Cada carta de producte té una forma arrodonida gràcies a `ClipRRect` i un radi de bord ajustable.
 *
 * Funcionalitats destacades:
 * - El paquet `card_swiper` s'utilitza per mostrar les cartes amb un efecte de desplaçament en pila (stack).
 * - Si la llista de productes està buida, es mostra un indicador de càrrega per informar l'usuari.
 * - Es permet la navegació als detalls del producte mitjançant la funció `Navigator.pushNamed`.
 */

class CardSwiper extends StatelessWidget {

  final List<ProductsList> products;

  const CardSwiper({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(this.products.length == 0){
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
          ),
      );
    }

    return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
          itemCount: products.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: product),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(product.safeImage),
                    fit: BoxFit.cover),
              ),
            );
          },
        ));
  }
}
