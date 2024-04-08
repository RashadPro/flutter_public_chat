import 'package:flutter/material.dart';

class TextFormFieldWithTitle extends StatelessWidget {
  final String? hintText, title;
  final IconData? prefixIcon;
  final IconData? suffixicon;
  final bool? obscureText;
  final TextEditingController? controller;
  const TextFormFieldWithTitle({
    super.key,
    this.hintText,
    this.controller,
    this.title,
    this.prefixIcon,
    this.suffixicon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
            color: Color(0xff8CAAB9),
            fontSize: 18,
          ),
        ),
        // Space
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: obscureText ?? true,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "PilatExtended-Regular",
            fontSize: 18,
          ),
          validator: (value) => value!.isEmpty ? "Requird" : null,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: Icon(
              suffixicon,
              size: 28,
              color: Colors.white,
            ),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(
                prefixIcon,
                size: 28,
                color: Colors.white,
              ),
            ),
            filled: true,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: "Inter",
              fontSize: 18,
            ),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(18.0),
            fillColor: const Color(0xff455A64),
          ),
        ),
      ],
    );
  }
}
