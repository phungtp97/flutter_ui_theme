import '../extension/context_ext.dart';
import 'package:flutter/material.dart';

import '../shared/shared.dart';

extension TextThemeExt on TextTheme {
  TextStyle get error => const TextStyle(
        color: Palette.error,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  TextStyle custom1(BuildContext context) => TextStyle(
        color: context.appTheme.isDark ? Palette.textDark : Palette.textLight,
        fontSize: 21,
        fontWeight: FontWeight.w600,
      );

  TextStyle subtitle(BuildContext context) => const TextStyle(
        color: Palette.textSubtitle,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
}
