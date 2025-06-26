import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color containerBorderColor;

  const AppColors({required this.containerBorderColor});

  @override
  AppColors copyWith({Color? containerBorderColor}) {
    return AppColors(
      containerBorderColor: containerBorderColor ?? this.containerBorderColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      containerBorderColor:
      Color.lerp(containerBorderColor, other.containerBorderColor, t)!,
    );
  }
}