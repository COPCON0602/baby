import 'package:flutter/material.dart';

class TextFieldCustomize extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? textInputType;
  final Widget? suffixicon;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final bool readOnly;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? boxColor;
  final bool obscureText;
  final String? errorText;

  const TextFieldCustomize({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.textInputType,
    this.suffixicon,
    this.onEditingComplete,
    this.onTap,
    this.readOnly = false,
    this.width,
    this.height,
    this.prefixIcon,
    this.borderColor,
    this.boxColor,
    this.obscureText = false,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            labelText ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          height: height,
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: boxColor,
            border: Border.all(color: borderColor ?? Colors.white, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(height ?? 16),
            ),
          ),
          child: Center(
            child: TextField(
              obscureText: obscureText,
              keyboardType: textInputType,
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                //isCollapsed: true,
                hintText: hintText,
                border: InputBorder.none, // Loại bỏ viền
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: suffixicon,
              ),
              onEditingComplete: onEditingComplete,
              onTap: onTap,
              readOnly: readOnly,
              onTapOutside: (pointer) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 2.0, left: 16),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}
