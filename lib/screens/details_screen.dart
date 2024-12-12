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
                CastingCards(),  // Asegúrate de tener este widget o elimina si no lo necesitas
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
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(product.image ?? 'https://via.placeholder.com/200x300'), // Usa la imagen del producto
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                product.title,  // Título dinámico del producto
                style: textTheme.headline5,
                maxLines: 2,  // Limita las líneas a 2
                overflow: TextOverflow.ellipsis, // Muestra puntos suspensivos si el texto es largo
              ),
              AutoSizeText(
                product.category.toString().split('.').last,  // Categoría del producto
                style: textTheme.subtitle1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  AutoSizeText(
                    product.rating.rate.toString(), // Calificación dinámica
                    style: textTheme.caption,
                    maxLines: 1,
                  ),
                ],
              )
            ],
          )
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
        maxLines: 5,  // Limita las líneas a 5
        overflow: TextOverflow.ellipsis, // Muestra puntos suspensivos si el texto es largo
      ),
    );
  }
}
