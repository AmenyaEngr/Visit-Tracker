import 'package:flutter/material.dart';

const extraSmallSize = 4.0;
const smallSize = 8.0;
const normalSize = 14.0;
const mediumSize = 16.0;
const largeSize = 24.0;
const extraLargeSize = 30.0;
const extraExtraLargeSize = 40.0;

const largeVerticalSpacing = SizedBox(height: 30);

const extraLargeVerticalSpacing = SizedBox(height: 40);

const mediumVerticalSpacing = SizedBox(height: 16);

const smallVerticalSpacing = SizedBox(height: 10);

const extraSmallVerticalSpacing = SizedBox(height: 5);

const largeHorizontalSpacing = SizedBox(width: 30);

const mediumHorizontalSpacing = SizedBox(width: 20);

const smallHorizontalSpacing = SizedBox(width: 10);

const extraSmallHorizontalSpacing = SizedBox(width: 5);

class AppTextStyles {
  static const extraLargeHeader = TextStyle(
    fontSize: extraLargeSize,
    fontWeight: FontWeight.bold,
  );
  static const headerStyle = TextStyle(
    fontSize: largeSize,
    fontWeight: FontWeight.bold,
  );

  static const largeSubHeaderStyle = TextStyle(
    fontSize: mediumSize,
    fontWeight: FontWeight.w700,
  );
  static const subHeaderStyle = TextStyle(
    fontSize: normalSize,
    fontWeight: FontWeight.w500,
  );
}
