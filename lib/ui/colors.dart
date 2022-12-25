import 'dart:math';

import 'package:flutter/material.dart';

/// https://stackoverflow.com/questions/46595466/is-there-a-map-of-material-design-colors-for-flutter
/// [material_color_generator | Flutter Package](https://pub.dev/packages/material_color_generator)
/// [Material Design Theme & Palette Color Generator](http://mcg.mbitson.com/#!?mcgpalette0=%231752ee)
///
///

class CustomColor {
  //
  // Matt green
  //
  static const MaterialColor mattgreen = MaterialColor(_mattgreenPrimaryValue, <int, Color>{
    50: Color(0xFFE7EDE8),
    100: Color(0xFFC3D1C6),
    200: Color(0xFF9CB3A0),
    300: Color(0xFF74947A),
    400: Color(0xFF567D5E),
    500: Color(_mattgreenPrimaryValue),
    600: Color(0xFF325E3B),
    700: Color(0xFF2B5332),
    800: Color(0xFF24492A),
    900: Color(0xFF17381C),
  });
  static const int _mattgreenPrimaryValue = 0xFF386641;

  static const MaterialColor mattgreenAccent = MaterialColor(_mattgreenAccentValue, <int, Color>{
    100: Color(0xFF79FF8C),
    200: Color(_mattgreenAccentValue),
    400: Color(0xFF13FF34),
    700: Color(0xFF00F823),
  });
  static const int _mattgreenAccentValue = 0xFF46FF60;

  //
  // Toss blue
  //
  static const MaterialColor tossblue = MaterialColor(_tossbluePrimaryValue, <int, Color>{
    50: Color(0xFFE3EAFD),
    100: Color(0xFFB9CBFA),
    200: Color(0xFF8BA9F7),
    300: Color(0xFF5D86F3),
    400: Color(0xFF3A6CF1),
    500: Color(_tossbluePrimaryValue),
    600: Color(0xFF144BEC),
    700: Color(0xFF1141E9),
    800: Color(0xFF0D38E7),
    900: Color(0xFF0728E2),
  });
  static const int _tossbluePrimaryValue = 0xFF1752EE;

  static const MaterialColor tossblueAccent = MaterialColor(_tossblueAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_tossblueAccentValue),
    400: Color(0xFFA5AFFF),
    700: Color(0xFF8B98FF),
  });
  static const int _tossblueAccentValue = 0xFFD8DCFF;

  //
  // Toss light blue
  //
  static const MaterialColor tosslightblue = MaterialColor(_tosslightbluePrimaryValue, <int, Color>{
    50: Color(0xFFE6F0FE),
    100: Color(0xFFC1DAFC),
    200: Color(0xFF98C1FB),
    300: Color(0xFF6FA8F9),
    400: Color(0xFF5095F7),
    500: Color(_tosslightbluePrimaryValue),
    600: Color(0xFF2C7AF5),
    700: Color(0xFF256FF3),
    800: Color(0xFF1F65F2),
    900: Color(0xFF1352EF),
  });
  static const int _tosslightbluePrimaryValue = 0xFF3182F6;

  static const MaterialColor tosslightblueAccent = MaterialColor(_tosslightblueAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_tosslightblueAccentValue),
    400: Color(0xFFB8C9FF),
    700: Color(0xFF9EB6FF),
  });
  static const int _tosslightblueAccentValue = 0xFFEBF0FF;

  //
  // Toss dark blue
  //
  static const MaterialColor tossdarkblue = MaterialColor(_tossdarkbluePrimaryValue, <int, Color>{
    50: Color(0xFFE4E6E8),
    100: Color(0xFFBCBFC6),
    200: Color(0xFF8F95A0),
    300: Color(0xFF626B79),
    400: Color(0xFF404B5D),
    500: Color(_tossdarkbluePrimaryValue),
    600: Color(0xFF1A263A),
    700: Color(0xFF162032),
    800: Color(0xFF121A2A),
    900: Color(0xFF0A101C),
  });
  static const int _tossdarkbluePrimaryValue = 0xFF1E2B40;

  static const MaterialColor tossdarkblueAccent = MaterialColor(_tossdarkblueAccentValue, <int, Color>{
    100: Color(0xFF5D8FFF),
    200: Color(_tossdarkblueAccentValue),
    400: Color(0xFF004CF6),
    700: Color(0xFF0044DC),
  });
  static const int _tossdarkblueAccentValue = 0xFF2A6BFF;

  //
  // Olive
  //
  static const MaterialColor olive = MaterialColor(_olivePrimaryValue, <int, Color>{
    50: Color(0xFFF0F0E0),
    100: Color(0xFFD9D9B3),
    200: Color(0xFFC0C080),
    300: Color(0xFFA6A64D),
    400: Color(0xFF939326),
    500: Color(_olivePrimaryValue),
    600: Color(0xFF787800),
    700: Color(0xFF6D6D00),
    800: Color(0xFF636300),
    900: Color(0xFF505000),
  });
  static const int _olivePrimaryValue = 0xFF808000;

  static const MaterialColor oliveAccent = MaterialColor(_oliveAccentValue, <int, Color>{
    100: Color(0xFFFFFF83),
    200: Color(_oliveAccentValue),
    400: Color(0xFFFFFF1D),
    700: Color(0xFFFFFF03),
  });
  static const int _oliveAccentValue = 0xFFFFFF50;

  //
  // Olive drab
  //
  static const MaterialColor olivedrap = MaterialColor(_olivedrapPrimaryValue, <int, Color>{
    50: Color(0xFFEDF1E5),
    100: Color(0xFFD3DDBD),
    200: Color(0xFFB5C791),
    300: Color(0xFF97B065),
    400: Color(0xFF819F44),
    500: Color(_olivedrapPrimaryValue),
    600: Color(0xFF63861F),
    700: Color(0xFF587B1A),
    800: Color(0xFF4E7115),
    900: Color(0xFF3C5F0C),
  });
  static const int _olivedrapPrimaryValue = 0xFF6B8E23;

  static const MaterialColor olivedrapAccent = MaterialColor(_olivedrapAccentValue, <int, Color>{
    100: Color(0xFFCDFF93),
    200: Color(_olivedrapAccentValue),
    400: Color(0xFF9DFF2D),
    700: Color(0xFF91FF14),
  });
  static const int _olivedrapAccentValue = 0xFFB5FF60;
}
// 4593fb
// 3182f6
// 3b84ea
// 1e2b40 // toss dark blue

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
