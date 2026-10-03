import 'package:flutter/material.dart';

class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;
  
  static BorderRadius get borderRadiusSm => BorderRadius.circular(sm);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(md);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(lg);
  static BorderRadius get borderRadiusXl => BorderRadius.circular(xl);
  static BorderRadius get borderRadiusFull => BorderRadius.circular(full);
}
