import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [TextStyles]는 앱 내에서 많이 사용되는 TextStyle을 통일하여 노출한다.
///
/// 이는 [TextStyle.copyWith()]를 사용하여 계층적으로 구현된다.
///
/// 스타일 Family
///   * Base 스타일은 일반적인 텍스트에 사용된다.
///     - [header], [primary], [secondary], [tertiary] 등
///
///   * Mono 스타일은 base폰트에서 파생된 것으로 Mono폰트를 사용한다.
///     입력 필드, 변경 가능한 값등을 표시하는데 사용한다.
///     - [primaryMono], [secondary], [tertiaryMono] 등
///
///   * Inversed 스타일은 base폰트에서 파생된 것으로 배경이 진할 때 사용한다.
///     (단순히 색상만 흰색으로 변경)
///
///
/// [fontWeight]는 기본적으로 [FontWeight.w300] 통일한다.
///
///
class TextStyles {
  static const TextStyle _baseFamily = TextStyle(fontWeight: lightWeight, color: generalColor);
  static final TextStyle _monoFamily =
      GoogleFonts.nanumGothicCoding(fontWeight: _baseFamily.fontWeight, color: _baseFamily.color);
  static final TextStyle _inversedFamily = _baseFamily.copyWith(color: Colors.white);

  static TextStyle get header => _baseFamily.copyWith(fontSize: headerSize);
  static TextStyle get primary => _baseFamily.copyWith(fontSize: primarySize);
  static TextStyle get secondary => _baseFamily.copyWith(fontSize: secondarySize);
  static TextStyle get tertiary =>
      _baseFamily.copyWith(fontSize: tertiarySize, color: lightColor, fontWeight: generalWeight);
  static TextStyle get small => _baseFamily.copyWith(fontSize: smallSize, color: lightColor, fontWeight: generalWeight);

  static TextStyle get headerLight => header.copyWith(color: lightColor);
  static TextStyle get primaryLight => primary.copyWith(color: lightColor);
  static TextStyle get secondaryLight => secondary.copyWith(color: lightColor);
  static TextStyle get tertiaryLight => tertiary.copyWith(color: lightColor);
  static TextStyle get smallLight => small.copyWith(color: lightColor);

  static TextStyle get headerWeak => header.copyWith(color: weakColor);
  static TextStyle get primaryWeak => primary.copyWith(color: weakColor);
  static TextStyle get secondaryWeak => secondary.copyWith(color: weakColor);
  static TextStyle get tertiaryWeak => tertiary.copyWith(color: weakColor);
  static TextStyle get smallWeak => small.copyWith(color: weakColor);

  static TextStyle get primaryMono => _monoFamily.copyWith(fontSize: primarySize + _size);
  static TextStyle get secondaryMono => _monoFamily.copyWith(fontSize: secondarySize + _size);
  static TextStyle get tertiaryMono => _monoFamily.copyWith(fontSize: tertiarySize + _size, color: lightColor);
  static TextStyle get smallMono => _monoFamily.copyWith(fontSize: smallSize + _size, color: lightColor);

  static TextStyle get headerInversed => _inversedFamily.copyWith(fontSize: headerSize);
  static TextStyle get primaryInversed => _inversedFamily.copyWith(fontSize: primarySize);
  static TextStyle get secondaryInversed => _inversedFamily.copyWith(fontSize: secondarySize);
  static TextStyle get tertiaryInversed => _inversedFamily.copyWith(fontSize: tertiarySize, fontWeight: generalWeight);
  static TextStyle get smallInversed => _inversedFamily.copyWith(fontSize: smallSize, fontWeight: generalWeight);

  static const double headerSize = 24;
  static const double primarySize = 20;
  static const double secondarySize = 18;
  static const double tertiarySize = 14;
  static const double smallSize = 11;
  static const double _size = 0.0; // nanumGothicCoding이 NotoSans보다 좀 크므로 보정

  static const FontWeight generalWeight = FontWeight.w400;
  static const FontWeight lightWeight = FontWeight.w300;

  static const Color generalColor = Color(0xFF424242); // grey[800]
  static const Color iconColor = Color(0xFF616161); // grey[700]
  static const Color lightColor = Color(0xFF757575); // grey[600]
  static const Color weakColor = Color(0xFFBDBDBD); // grey[400]
}

/// Bootstrap의 Button을 참조함
class ButtonStyles {
  static ButtonStyle get primary => TextButton.styleFrom(foregroundColor: Colors.blue);
  static ButtonStyle get secondary => TextButton.styleFrom(foregroundColor: Colors.grey);
  static ButtonStyle get success => TextButton.styleFrom(foregroundColor: Colors.green);
  static ButtonStyle get danger => TextButton.styleFrom(foregroundColor: Colors.red);
  static ButtonStyle get warning => TextButton.styleFrom(foregroundColor: Colors.yellow);
}

/// [xs]: 버튼, input 등
/// [sm]:
/// [md]:
/// [lg]:
/// [xl]: 다이얼로그, 페이지등
class Corners {
  static const double xs = 5;
  static const Radius xsRadius = const Radius.circular(xs);
  static const BorderRadius xsBorder = const BorderRadius.all(xsRadius);

  static const double sm = 8;
  static const Radius smRadius = const Radius.circular(sm);
  static const BorderRadius smBorder = const BorderRadius.all(smRadius);

  static const double md = 12;
  static const Radius mdRadius = const Radius.circular(md);
  static const BorderRadius mdBorder = const BorderRadius.all(mdRadius);

  static const double lg = 15;
  static const Radius lgRadius = const Radius.circular(lg);
  static const BorderRadius lgBorder = const BorderRadius.all(lgRadius);

  static const double xl = 20;
  static const Radius xlRadius = const Radius.circular(xl);
  static const BorderRadius xlBorder = const BorderRadius.all(xlRadius);

  static const double iPhone = 40;
  static const Radius iPhoneRadius = const Radius.circular(iPhone);
  static const BorderRadius iPhoneBorder = const BorderRadius.all(iPhoneRadius);
}

class VSpace {
  VSpace._();

  static SizedBox get xs => SizedBox(height: Insets.xs);
  static SizedBox get sm => SizedBox(height: Insets.sm);
  static SizedBox get md => SizedBox(height: Insets.md);
  static SizedBox get lg => SizedBox(height: Insets.lg);
  static SizedBox get xl => SizedBox(height: Insets.xl);
}

class HSpace {
  HSpace._();

  static SizedBox get xs => SizedBox(width: Insets.xs);
  static SizedBox get sm => SizedBox(width: Insets.sm);
  static SizedBox get md => SizedBox(width: Insets.md);
  static SizedBox get lg => SizedBox(width: Insets.lg);
  static SizedBox get xl => SizedBox(width: Insets.xl);
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;
  // Regular paddings
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get md => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 32 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

/// https://medium.com/@samarth_agarwal/turn-images-to-grayscale-in-flutter-the-colorfiltered-widget-16de44cf8045
class ColorFilters {
  static const greyScale = ColorFilter.matrix(_greyScale);
  static const _greyScale = <double>[
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const darkerAlphaScale = ColorFilter.matrix(_greyAlphaScale);
  static const _greyAlphaScale = <double>[
    0.9, 0, 0, 0, 0, //
    0, 0.9, 0, 0, 0, //
    0, 0, 0.9, 0, 0, //
    0, 0, 0, 1, 0, //
  ];
}

const visualDensityMin =
    VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity);
