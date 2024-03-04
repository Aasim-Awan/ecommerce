import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.size,
      this.color = const Color(0xFF1F1F39),
      this.decoration,
      this.weight,
      this.textDecoration});

  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final bool? decoration;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",

      style: GoogleFonts.urbanist(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontStyle: FontStyle.normal,
        decoration: textDecoration,
      ),
    );
  }
}
