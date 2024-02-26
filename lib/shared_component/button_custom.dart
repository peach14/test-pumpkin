import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType { outlined, filled, circle }

class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
      {Key? key,
      this.color = Colors.deepOrange,
      required this.text,
      required this.onTap,
      this.enable = true,
      this.height = 70,
      this.width,
      this.textStyle,
      this.textColors,
      this.child,
      this.buttonType = ButtonType.filled, // new parameter for button type
      this.borderRadius = 90,
      this.borderColors,
      this.keys})
      : super(key: key);

  final Color? color;
  final String text;
  final Function onTap;
  final bool enable;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Widget? child;
  final ButtonType buttonType;
  final double borderRadius;
  final Color? textColors;
  final Color? borderColors;
  final GlobalKey<FormState>? keys;

  @override
  Widget build(BuildContext context) {
    final borderColor = enable ? Colors.deepOrange : Colors.white38;

    final textColor = textColors ??
        (buttonType == ButtonType.outlined
            ? borderColor
            : enable
                ? Colors.black
                : Colors.white38);

    final buttonColor = buttonType == ButtonType.outlined
        ? Colors.white
        : color ?? Colors.deepOrange;

    final borderSide =
        BorderSide(color: borderColors ?? Colors.deepOrange, width: 1);

    final buttonShape = buttonType == ButtonType.circle
        ? const CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide,
          );

    return SizedBox(
      width: width,
      height: 70.h,
      child: MaterialButton(
        elevation: 0,
        onPressed: enable ? () => onTap() : null,
        disabledColor: Colors.white38,
        color: buttonColor,
        shape: buttonShape,
        child: child ??
            Text(
              text,
              style: textStyle ?? TextStyle(color: textColor, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
