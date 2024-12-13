import 'package:fakestore/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fakestore/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';  // Importa AutoSizeText

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsList producte = ModalRoute.of(context)?.settings.arguments as ProductsList;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(product: producte), // Pasa el producto al app bar
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(product: producte), // Pasa el producto a PosterAndTitle
                _Overview(product: producte),
                //CastingCards(),  // Asegúrate de tener este widget o elimina si no lo necesitas
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
            product.title,  // Título dinámico del producto
            style: TextStyle(fontSize: 16),
            maxLines: 2, // Controla cuántas líneas puede ocupar el título
            overflow: TextOverflow.ellipsis,  // Muestra "..." si el texto se corta
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(product.image ?? 'https://via.placeholder.com/500x300'), // Usa la imagen del producto
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

    // Calcula el número de estrellas llenas según el rating
    final int filledStars = product.rating.rate.floor(); // Número de estrellas completas
    final double partialStar = product.rating.rate - filledStars; // Porción de estrella parcial

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centra todo horizontalmente
        children: [
          // Imagen centrada
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(product.image ?? 'https://via.placeholder.com/200x300'),
              height: 300, // Ajusta la altura de la imagen según sea necesario
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20, // Espacio entre la imagen y el título
          ),
          // Título centrado
          Text(
            product.title, // Título dinámico del producto
            style: textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10, // Espacio entre el título y la categoría
          ),
          // Categoría centrada
          Text(
            product.category.toString().split('.').last, // Categoría del producto
            style: textTheme.subtitle1?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10, // Espacio entre la categoría y el rating
          ),
          // Rating con estrellas
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra la fila horizontalmente
            children: List.generate(5, (index) {
              if (index < filledStars) {
                // Estrella llena
                return const Icon(Icons.star, color: Colors.amber, size: 20);
              } else if (index == filledStars && partialStar > 0) {
                // Estrella parcial
                return Icon(Icons.star_half, color: Colors.amber, size: 20);
              } else {
                // Estrella vacía
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
