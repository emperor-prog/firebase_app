import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/shop/models/products_model.dart';
import 'package:flutter_application_1/services/shop_service.dart';

import 'package:flutter_application_1/utils/custom_color.dart';

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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: products!.isEmpty
                ? const Center(child: Text("No Products Found"))
                : Column(
                    children: [
                      for (int i = 0; i < products!.length; i++)
                        Text(products![i].title),
                    ],
                  )),
      ),
    );
  }
}
