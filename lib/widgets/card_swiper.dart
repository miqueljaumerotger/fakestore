import 'package:card_swiper/card_swiper.dart';
import 'package:fakestore/models/models.dart';
import 'widgets.dart';

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
        // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        height: size.height * 0.5,
        // color: Colors.red,
        child: Swiper(
          itemCount: products.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            // print(product.image);
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
