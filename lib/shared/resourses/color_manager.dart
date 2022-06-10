import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = HexColor.fromHex('#F26522');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color blueColor = HexColor.fromHex('#223263');
  static Color grey = HexColor.fromHex('#737477');
  static Color lightGrey = HexColor.fromHex('#9E9E9E');
  static Color primaryOpacity70 = HexColor.fromHex('#B3ED9728');

//
  static Color darkPrimary = HexColor.fromHex('#d17d11');
  static Color grey1 = HexColor.fromHex('#707070');
  static Color grey2 = HexColor.fromHex('#797979');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color error = HexColor.fromHex('#e61f34');
  static Color blueDark = HexColor.fromHex('#223263');

  /// basic colors
  static const kTeal50 = Color(0xFFE0F2F1);
  static const kTeal100 = Color(0xFF3FC1BE);
  static const kTeal400 = Color(0xFF26A69A);
  static const kGrey900 = Color(0xFF263238);
  static const kGrey600 = Color(0xFF546E7A);
  static const kGrey200 = Color(0xFFEEEEEE);
  static const kGrey400 = Color(0xFF90a4ae);
  static const kErrorRed = Color(0xFFe74c3c);
  static const kColorRed = Color(0xFFF3090B);
  static const kSurfaceWhite = Color(0xFFFFFBFA);
  static const kRedColorHeart = Color(0xFFf22742);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
