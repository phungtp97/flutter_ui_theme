import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extension/theme_ext.dart';
import '../../extension/string_ext.dart';
import '../../extension/context_ext.dart';
import '../shared/shared.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: 'Dark Mode'.text(style: context.textTheme.displaySmall),
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0.0,
          backgroundColor: context.dynamicBackground1,
          automaticallyImplyLeading: !kIsWeb,
          iconTheme: context.theme.iconTheme,
          actions: [
            Center(
              child: Consumer<AppTheme>(builder: (context, theme, child) {
                return TextButton(
                    onPressed: () {
                      theme.toggleTheme();
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        foregroundColor: Palette.primary
                    ),
                    child: 'Toggle Theme'
                        .text(style: context.textTheme.titleMedium));
              }),
            ),
          ],
        ),
        body: Column(
          ///add example of text style from textTheme
          children: <Widget>[
            const SizedBox(height: 12),
            'Body Medium'.text(style: context.textTheme.bodyMedium),
            const SizedBox(height: 12),
            'Display Large'.text(style: context.textTheme.displayLarge),
            const SizedBox(height: 12),
            'Display Medium'.text(style: context.textTheme.displayMedium),
            const SizedBox(height: 12),
            'Display Small'.text(style: context.textTheme.displaySmall),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Palette.primary),
              child: 'Label Medium'.text(
                style: context.textTheme.labelMedium,
              ),
            ),
            const Divider(),
            const SizedBox(height: 12),
            'Custom'.text(
                style: context.textTheme.custom1(context),
                config: TextWidgetConfig.h1())
          ],
        ));
  }
}