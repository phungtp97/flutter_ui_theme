import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/shared.dart';

extension ContextExt on BuildContext {
  AppTheme get appTheme => read();
  TextTheme get textTheme => theme.textTheme;
  ThemeData get theme => Theme.of(this);

  Color get dynamicBackground1 => appTheme.isDark ? Palette.darkBackground1 : Palette.lightBackground1;

  Color get dynamicBackground2 => appTheme.isDark ? Palette.darkBackground2 : Palette.lightBackground2;

  Color get dynamicTextColor => appTheme.isDark ? Palette.textDark : Palette.textLight;
}
