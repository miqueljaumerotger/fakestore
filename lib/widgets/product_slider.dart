import 'package:fakestore/models/products_list.dart';
import 'widgets.dart';

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
          const SizedBox(height: 5), // Espacio entre el título y el slider
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

