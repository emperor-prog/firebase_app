import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/shop/models/products_model.dart';
import 'package:flutter_application_1/services/shop_service.dart';

import 'package:flutter_application_1/utils/custom_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Product>? products;

  final ShopService service = ShopService();

  void fetchAllProducts() async {
    products = await service.fetchAllProducts(context: context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Women's tops",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: const [
          Icon(
            Icons.search_outlined,
            color: CustomColor.textBlackColor,
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: CustomColor.textBlackColor,
            )),
        backgroundColor: CustomColor.appBackGroundColor,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: products == null
              ? const Center(child: CircularProgressIndicator())
              : products!.isEmpty
                  ? const Center(child: Text("No Products Found"))
                  : GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: products!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 9 / 16, crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          product: products![index],
                        );
                      })),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  color: CustomColor.textGreyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(product.image),
                  ),
                ),
              ),
              const Positioned(
                right: -10,
                bottom: -10,
                child: Card(
                  elevation: 8,
                  color: CustomColor.appBackGroundColor,
                  shape: CircleBorder(),
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Icon(Icons.favorite_border_outlined),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              RatingBar.builder(
                initialRating: product.rating.rate,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: const EdgeInsets.all(0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              Text(
                '(${product.rating.count})',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            child: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              '${product.price}\$',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
