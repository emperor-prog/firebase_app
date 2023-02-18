import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/shop/models/products_model.dart';
import 'package:flutter_application_1/features/shop/widgets/product_card.dart';
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
                    },
                  ),
      ),
    );
  }
}
