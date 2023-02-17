import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/custom_snackbar.dart';
import 'package:dio/dio.dart' as dio;

void dioErrorHandle(
    {required dio.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showToastBar(
          context: context, message: response.data['msg'], onSucess: () {});
      break;
    case 500:
      showToastBar(
          context: context, message: response.data['error'], onSucess: () {});
      break;
    default:
      showToastBar(context: context, message: response.data, onSucess: () {});
  }
}
