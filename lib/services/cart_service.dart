import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/features/cart/models/cart_product.dart';
import 'package:flutter_application_1/features/shop/models/products_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class CartService {
  String cart = 'shopping_cart';

  Future<void> init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    await Hive.initFlutter(appDocPath)
        .then((value) => debugPrint('Hive initialized'))
        .onError((error, stackTrace) => debugPrint('Hive not initialized'));

    Hive.registerAdapter(CartItemAdapter());

    await Hive.openBox<CartItem>(cart);

    await Hive.openBox('user_box');
  }

  Future<void> addToCart({required CartItem product}) async {
    Box<CartItem> items = Hive.box<CartItem>(cart);
    int count = 0;
    bool itemFound = false;

    if (items.isEmpty) {
      await items.put(
        0,
        CartItem(
          count: product.count,
          id: product.id,
          title: product.title,
          price: product.price,
          image: product.image,
        ),
      );
    } else {
      for (int i = 0; i < items.length; i++) {
        var data = items.getAt(i);
        if (data!.id == product.id) {
          itemFound = true;
          count = data.count;
          count = count + 1;

          await items.put(
            i,
            CartItem(
              count: count,
              id: product.id,
              title: product.title,
              price: product.price,
              image: product.image,
            ),
          );
          break;
        }

        itemFound = false;
      }

      if (!itemFound) {
        await items.put(
          items.length,
          CartItem(
            count: product.count,
            id: product.id,
            title: product.title,
            price: product.price,
            image: product.image,
          ),
        );
      }
    }
  }

  Future<void> removeFromCart({required CartItem product}) async {
    Box<CartItem> items = Hive.box<CartItem>(cart);
    int count = 0;
    for (int i = 0; i < items.length; i++) {
      var data = items.getAt(i);
      if (data!.id == product.id) {
        count = data.count;
        count = count - 1;

        if (count <= 0) {
          await items.deleteAt(i);
        } else {
          await items.put(
            i,
            CartItem(
              count: count,
              id: product.id,
              title: product.title,
              price: product.price,
              image: product.image,
            ),
          );
        }
      }
    }
  }

  void deleteItem({required Product product}) async {
    Box<CartItem> items = Hive.box<CartItem>(cart);

    await items.deleteAt(product.id);
  }
}
