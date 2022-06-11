import 'package:flutter/material.dart';
import 'package:ibtikartask/shared/resourses/color_manager.dart';
import 'package:sizer/sizer.dart';

final kBoxShadow = [
  BoxShadow(
    color: ColorManager.kPrimaryColor,
    spreadRadius: 5,
    blurRadius: 30.sp,
    offset: const Offset(0, 3),
  ),
];

final kTextShadow = [
  Shadow(offset: Offset(0, 0.1.h), blurRadius: 6.0.sp, color: ColorManager.kTextShadowColor),
];