import 'package:flutter/material.dart';
import 'package:ibtikartask/shared/resourses/color_manager.dart';
import 'package:sizer/sizer.dart';

import '../../helper/constant.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily,
        FontWeight fontWeight, Color color) =>
    TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        shadows: kTextShadow,
        color: color);

// regular style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstant.fontFamily, FontWeightManager.regular, color);
}

// light text style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstant.fontFamily, FontWeightManager.light, color);
}

// bold text style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstant.fontFamily, FontWeightManager.bold, color);
}

// semi bold text style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstant.fontFamily, FontWeightManager.semiBold, color);
}

// medium text style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstant.fontFamily, FontWeightManager.medium, color);
}

final kSubTitleCardBoxTextStyle = TextStyle(
  color: ColorManager.kSubTitleCardBoxColor,
  fontSize: 9.sp,
);
