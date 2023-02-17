import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/custom_color.dart';

class SocialIcon extends StatelessWidget {
  final String url;
  final void Function()? onTap;

  const SocialIcon({
    super.key,
    required this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: CustomColor.textGreyColor.withOpacity(0.4),
                  spreadRadius: 2)
            ]),
        child: Image.network(
          url,
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
