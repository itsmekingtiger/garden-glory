import 'dart:math';

import 'package:flutter/material.dart';

/// https://stackoverflow.com/questions/46595466/is-there-a-map-of-material-design-colors-for-flutter
/// [material_color_generator | Flutter Package](https://pub.dev/packages/material_color_generator)
/// [Material Design Theme & Palette Color Generator](http://mcg.mbitson.com/#!?mcgpalette0=%231752ee)

const MaterialColor tossColor = MaterialColor(
  0xff1752ee,
  <int, Color>{
    50: Color(0xffe3eafd),
    100: Color(0xffb9cbfa),
    200: Color(0xff8ba9f7),
    300: Color(0xff5d86f3),
    400: Color(0xff3a6cf1),
    500: Color(0xff1752ee),
    600: Color(0xff144bec),
    700: Color(0xff1141e9),
    800: Color(0xff0d38e7),
    900: Color(0xff0728e2),
  },
);

const tossButtonBg = Color(0xffe6f0fe);
const tossButtonFg = Color(0xff3182f6);

List<Color> colorArray = [
  Color(0xFF00B3E6),
  Color(0xFF00E680),
  Color(0xFF1AB399),
  Color(0xFF1AFF33),
  Color(0xFF3366E6),
  Color(0xFF33991A),
  Color(0xFF33FFCC),
  Color(0xFF4D8000),
  Color(0xFF4D8066),
  Color(0xFF4D80CC),
  Color(0xFF4DB380),
  Color(0xFF4DB3FF),
  Color(0xFF66664D),
  Color(0xFF6666FF),
  Color(0xFF6680B3),
  Color(0xFF66991A),
  Color(0xFF66994D),
  Color(0xFF66E64D),
  Color(0xFF809900),
  Color(0xFF809980),
  Color(0xFF80B300),
  Color(0xFF9900B3),
  Color(0xFF991AFF),
  Color(0xFF999933),
  Color(0xFF999966),
  Color(0xFF99E6E6),
  Color(0xFF99FF99),
  Color(0xFFB33300),
  Color(0xFFB34D4D),
  Color(0xFFB366CC),
  Color(0xFFB3B31A),
  Color(0xFFCC80CC),
  Color(0xFFCC9999),
  Color(0xFFCCCC00),
  Color(0xFFCCFF1A),
  Color(0xFFE6331A),
  Color(0xFFE64D66),
  Color(0xFFE666B3),
  Color(0xFFE666FF),
  Color(0xFFE6B333),
  Color(0xFFE6B3B3),
  Color(0xFFE6FF80),
  Color(0xFFFF1A66),
  Color(0xFFFF3380),
  Color(0xFFFF33FF),
  Color(0xFFFF4D4D),
  Color(0xFFFF6633),
  Color(0xFFFF99E6),
  Color(0xFFFFB399),
  Color(0xFFFFFF99),
];

/// [Determine If A Color Is Bright Or Dark Using JavaScript - Andreas Wik](https://awik.io/determine-color-bright-dark-using-javascript/)
bool isLightColor(int r, int g, int b) {
  // HSP (Highly Sensitive Poo) equation from http://alienryderflex.com/hsp.html
  final hsp = sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b));

  // Using the HSP value, determine whether the color is light or dark
  return hsp > 127.5;
}

List<int> toRGB(int color) {
  return [
    (color >> 16) & 0xFF, // red
    (color >> 8) & 0xFF, // green
    color & 0xFF, // blue
  ];
}
