import 'package:fakestore/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:fakestore/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
            // Mostrar productos de las categorías relevantes
            if (productsProvider.isLoading)
              const Center(child: CircularProgressIndicator()) // Indicador de carga mientras se obtiene la data
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
