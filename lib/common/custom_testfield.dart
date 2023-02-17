import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/custom_color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool isObscured;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.labelText,
      this.isObscured = false,
      this.validator,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: CustomColor.textGreyColor.withOpacity(0.4),
                spreadRadius: 2)
          ]),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isObscured,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
