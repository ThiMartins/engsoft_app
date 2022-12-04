import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color colorText;
  final EdgeInsetsGeometry padding;
  final double? minHeight;
  final double? radius;

  AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    Color? color,
    Color? colorText,
    EdgeInsetsGeometry? padding,
    this.minHeight,
    this.radius,
  })  : color = color ?? AppColor.primaryColor,
        colorText = colorText ?? AppColor.buttonTextColor,
        padding = padding ?? EdgeInsets.zero,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight ?? 0),
        child: MaterialButton(
          color: color,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? (minHeight ?? 54) / 2)
          ),
          onPressed: onPressed,
          minWidth: double.infinity,
          child: Text(
            text,
            style: TextStyle(
              color: colorText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
/*

ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            foregroundColor: MaterialStateProperty.all<Color>(colorText),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((minHeight ?? 2) / 2),
            )),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: colorText,
              fontWeight: FontWeight.bold,
            ),
          ),
        )

 */
