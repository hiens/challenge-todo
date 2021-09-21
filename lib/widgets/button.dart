import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum _ButtonType { ELEVATED, TEXT, OUTLINED }

class Button extends StatelessWidget {
  const Button({
    required this.type,
    required this.label,
    required this.borderRadius,
    required this.isFullWidth,
    required this.iconRight,
    required this.color,
    this.onPressed,
    this.icon,
    this.textColor,
    this.elevation,
    this.textStyle,
  });

  factory Button.elevated({
    required String label,
    Function()? onPressed,
    Icon? icon,
    Color? color,
    Color? textColor,
    bool? isFullWidth,
    bool? iconRight,
    BorderRadius? borderRadius,
    double? elevation,
    TextStyle? textStyle,
  }) {
    return Button(
      type: _ButtonType.ELEVATED,
      onPressed: onPressed,
      label: label,
      color: color ?? Get.theme.primaryColor,
      textColor: textColor,
      icon: icon,
      isFullWidth: isFullWidth ?? false,
      iconRight: iconRight ?? false,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      elevation: elevation,
      textStyle: textStyle,
    );
  }

  factory Button.outlined({
    required String label,
    Function()? onPressed,
    Icon? icon,
    Color? color,
    Color? textColor,
    bool? isFullWidth,
    bool? iconRight,
    BorderRadius? borderRadius,
    double? elevation,
    TextStyle? textStyle,
  }) {
    return Button(
      type: _ButtonType.OUTLINED,
      onPressed: onPressed,
      label: label,
      color: color ?? Get.theme.primaryColor,
      textColor: textColor,
      icon: icon,
      isFullWidth: isFullWidth ?? false,
      iconRight: iconRight ?? false,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      elevation: elevation,
      textStyle: textStyle,
    );
  }

  factory Button.text({
    required String label,
    Function()? onPressed,
    Icon? icon,
    Color? color,
    Color? textColor,
    bool? isFullWidth,
    bool? iconRight,
    BorderRadius? borderRadius,
    double? elevation,
    TextStyle? textStyle,
  }) {
    return Button(
      type: _ButtonType.TEXT,
      onPressed: onPressed,
      label: label,
      color: color ?? Get.theme.primaryColor,
      textColor: textColor,
      icon: icon,
      isFullWidth: isFullWidth ?? false,
      iconRight: iconRight ?? false,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      elevation: elevation,
      textStyle: textStyle,
    );
  }

  final _ButtonType type;
  final String label;
  final BorderRadius borderRadius;
  final bool isFullWidth;
  final bool iconRight;
  final Color color;
  final Function()? onPressed;
  final Icon? icon;
  final Color? textColor;
  final double? elevation;
  final TextStyle? textStyle;

  Widget _buildButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null && !iconRight)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              icon!.icon,
              size: (textStyle?.fontSize ?? 14) + 2,
            ),
          ),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? const TextStyle(fontSize: 12),
          ),
        ),
        if (icon != null && iconRight)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              icon!.icon,
              size: (textStyle?.fontSize ?? 14) + 2,
            ),
          ),
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    switch (type) {
      case _ButtonType.OUTLINED:
        return ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: elevation != null
              ? MaterialStateProperty.resolveWith((_) => elevation)
              : Get.theme.outlinedButtonTheme.style?.elevation,
          padding: MaterialStateProperty.resolveWith(
              (_) => const EdgeInsets.symmetric(horizontal: 8)),
          textStyle: MaterialStateProperty.resolveWith(
            (_) => GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.resolveWith(
            (_) => RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
          side: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) => BorderSide(
                color: states.contains(MaterialState.disabled)
                    ? Colors.grey
                    : color),
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled)
                      ? Colors.grey
                      : color),
          overlayColor:
              MaterialStateProperty.resolveWith((_) => color.withOpacity(0.1)),
        );
      case _ButtonType.TEXT:
        return ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: elevation != null
              ? MaterialStateProperty.resolveWith((_) => elevation)
              : Get.theme.textButtonTheme.style?.elevation,
          padding: MaterialStateProperty.resolveWith(
              (_) => const EdgeInsets.symmetric(horizontal: 8)),
          textStyle: MaterialStateProperty.resolveWith(
            (_) => GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.resolveWith(
            (_) => RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled)
                      ? Colors.grey
                      : color),
          overlayColor:
              MaterialStateProperty.resolveWith((_) => color.withOpacity(0.1)),
        );
      default:
        return ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: elevation != null
              ? MaterialStateProperty.resolveWith((_) => elevation)
              : Get.theme.elevatedButtonTheme.style?.elevation,
          padding: MaterialStateProperty.resolveWith(
              (_) => const EdgeInsets.symmetric(horizontal: 8)),
          textStyle: MaterialStateProperty.resolveWith(
            (_) => GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.resolveWith(
            (_) => RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
              (_) => textColor ?? Colors.white),
          backgroundColor: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled)
                      ? Colors.grey
                      : color),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: isFullWidth ? double.infinity : null,
      child: Builder(
        builder: (_) {
          switch (type) {
            case _ButtonType.TEXT:
              return TextButton(
                onPressed: onPressed,
                child: _buildButtonContent(),
                style: _buttonStyle(),
              );
            case _ButtonType.OUTLINED:
              return OutlinedButton(
                onPressed: onPressed,
                child: _buildButtonContent(),
                style: _buttonStyle(),
              );
            default:
              return ElevatedButton(
                onPressed: onPressed,
                child: _buildButtonContent(),
                style: _buttonStyle(),
              );
          }
        },
      ),
    );
  }
}
