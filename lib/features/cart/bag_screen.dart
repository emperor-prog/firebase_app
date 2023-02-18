import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/models/cart_product.dart';
import 'package:flutter_application_1/features/cart/widgets/bag_item_card.dart';
import 'package:flutter_application_1/services/cart_service.dart';

import 'package:flutter_application_1/utils/custom_color.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService service = CartService();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Bag",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: const [
          Icon(
            Icons.search_outlined,
            color: CustomColor.textBlackColor,
          )
        ],
        backgroundColor: CustomColor.appBackGroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ValueListenableBuilder(
              valueListenable: Hive.box<CartItem>(service.cart).listenable(),
              builder: (context, Box<CartItem> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text("No Items found"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    CartItem? currentContact = box.getAt(index);

                    return BagItemCard(currentContact: currentContact);
                  },
                );
              },
            )),
      ),
    );
  }
}
