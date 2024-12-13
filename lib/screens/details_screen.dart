import 'package:fakestore/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fakestore/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

/**
 * Pantalla de Detalls del Producte: Aquesta pantalla mostra la informació detallada d'un producte, incloent-hi el seu
 * títol, imatge, categoria, valoració, i descripció. Utilitza el widget `CustomScrollView` per mostrar el contingut de forma
 * dinàmica i reutilitzable.
 * 
 * Components principals:
 *
 * 1. **Classe `DetailsScreen`**:
 *    - Aquesta classe és la pantalla principal on es mostren els detalls del producte.
 *    - Utilitza el `ModalRoute.of(context)?.settings.arguments` per obtenir el producte seleccionat i mostrar-lo a la UI.
 *    - La pantalla fa servir `CustomScrollView` per a un desplaçament flexible amb `SliverList` i `SliverAppBar`.
 *
 * 2. **Classe `_CustomAppBar`**:
 *    - Crea un app bar personalitzat amb una imatge de fons i el títol del producte.
 *    - Utilitza `AutoSizeText` per ajustar dinàmicament el títol en funció de la longitud del text, amb un màxim de tres línies i punts suspensius si el text és massa llarg.
 *    - Mostra la imatge del producte amb una animació de desvaniment (`FadeInImage`), utilitzant una imatge de càrrega mentre es carrega la imatge real.
 * 
 * 3. **Classe `_PosterAndTitile`**:
 *    - Aquesta classe mostra una imatge del producte amb el seu títol, categoria i valoració.
 *    - La imatge es presenta centrada i s'adapta a la pantalla amb una mida personalitzada.
 *    - Mostra el títol del producte amb un estil de text gros i centrat, així com la categoria i la valoració en estrelles.
 *    - La valoració del producte es converteix en estrelles plenes, parcials i buides segons el valor de la valoració.
 *
 * 4. **Classe `_Overview`**:
 *    - Mostra la descripció detallada del producte amb un estil de text justificat.
 *    - Limita el nombre de línies a 13, amb una funcionalitat d'overflow amb punts suspensius si la descripció és més llarga.
 *    - Utilitza `AutoSizeText` per gestionar la mida del text en funció de la longitud de la descripció, evitant que el text es sobreposi.
 * 
 * Funcionalitats destacades:
 * - La pantalla mostra dinàmicament la informació d'un producte amb una estructura de scroll personalitzada.
 * - Es fa ús de `AutoSizeText` per ajustar automàticament el text en funció de la pantalla.
 * - La valoració del producte es presenta amb estrelles per facilitar la comprensió visual de la qualitat del producte.
 * - L'ús de `FadeInImage` permet carregar les imatges del producte de manera eficient.
 */

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsList producte = ModalRoute.of(context)?.settings.arguments as ProductsList;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(product: producte), // Pasa el producta a l'app bar
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(product: producte), // Pasa el producte a PosterAndTitle
                _Overview(product: producte),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final ProductsList product;

  const _CustomAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: AutoSizeText(
            product.title,
            style: TextStyle(fontSize: 16),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,  // Mostra "..." si el text es talla
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(product.image ?? 'https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final ProductsList product;

  const _PosterAndTitile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Calcula el nombre d'estrelles plenes segons el rating
    final int filledStars = product.rating.rate.floor(); // Nombre d'estrelles completes
    final double partialStar = product.rating.rate - filledStars; // Porció d'estrella parcial

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagen centrada
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(product.image ?? 'https://via.placeholder.com/200x300'),
              height: 300,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20, // Espaci entre la imatge i el títol
          ),
          Text(
            product.title,
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10, // Espai entre el títol i la categoria
          ),
          Text(
            product.category.toString().split('.').last,
            style: textTheme.titleMedium?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10, // Espai entre la categoria i el rating
          ),
          // Rating amb estrelles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              if (index < filledStars) {
                // Estrella plena
                return const Icon(Icons.star, color: Colors.amber, size: 20);
              } else if (index == filledStars && partialStar > 0) {
                // Estrella parcial
                return Icon(Icons.star_half, color: Colors.amber, size: 20);
              } else {
                // Estrella buida
                return const Icon(Icons.star_border, color: Colors.amber, size: 20);
              }
            }),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final ProductsList product;

  const _Overview({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AutoSizeText(
        product.description,  // Descripción del producto
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
        maxLines: 13,  // Limita las líneas a 5
        overflow: TextOverflow.ellipsis, // Muestra puntos suspensivos si el texto es largo
      ),
    );
  }
}
