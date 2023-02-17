import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/custom_color.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                  backgroundColor: CustomColor.appButtonColor),
              onPressed: onPressed,
              child: Text(buttonText)),
        ),
      ],
    );
  }
}
