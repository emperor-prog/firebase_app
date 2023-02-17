import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/dio_error_handle.dart';
import 'package:flutter_application_1/features/shop/models/products_model.dart';
import 'package:flutter_application_1/utils/custom_snackbar.dart';

class ShopService {
  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
  }) async {
    List<Product> products = [];

    try {
      var response = await Dio().get(
        'https://fakestoreapi.com/products',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      // ignore: use_build_context_synchronously
      dioErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            var data = response.data;
            for (int i = 0; i < data.length; i++) {
              products.add(Product.fromJson(data[i]));
            }
          });

      return products;
    } catch (e) {
      showToastBar(context: context, message: '$e', onSucess: () {});
      throw '$e';
    }
  }
}
