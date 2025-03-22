import 'package:flutter/material.dart';

class CaptchaTheme {
  final Color numberColor;
  final Color backgroundColor;
  final List<Color> scribbleColors;  // Changed from Color to List<Color>
  final double fontSize;
  final double scribbleIntensity;
  final String fontFamily;
  final String instructionText;
  final BorderRadius borderRadius;
  final BoxShadow? boxShadow;

  const CaptchaTheme({
    this.numberColor = Colors.black87,
    this.backgroundColor = Colors.white,
    this.scribbleColors = const [Colors.grey, Colors.blue, Colors.red, Colors.green],  // Default colors
    this.fontSize = 32.0,
    this.scribbleIntensity = 1.0,
    this.fontFamily = 'Roboto',
    this.instructionText = 'Type the numbers you see',
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.boxShadow,
  });

  CaptchaTheme copyWith({
    Color? numberColor,
    Color? backgroundColor,
    List<Color>? scribbleColors,  // Updated parameter
    double? fontSize,
    double? scribbleIntensity,
    String? fontFamily,
    String? instructionText,
    BorderRadius? borderRadius,
    BoxShadow? boxShadow,
  }) {
    return CaptchaTheme(
      numberColor: numberColor ?? this.numberColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      scribbleColors: scribbleColors ?? this.scribbleColors,
      fontSize: fontSize ?? this.fontSize,
      scribbleIntensity: scribbleIntensity ?? this.scribbleIntensity,
      fontFamily: fontFamily ?? this.fontFamily,
      instructionText: instructionText ?? this.instructionText,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }
}
