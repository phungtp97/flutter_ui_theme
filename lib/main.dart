import 'package:dynamic_widget_ext/extension/context_ext.dart';
import 'package:dynamic_widget_ext/extension/string_ext.dart';
import 'package:dynamic_widget_ext/pages/messenger_page.dart';
import 'package:dynamic_widget_ext/pages/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'shared/shared.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppTheme(false),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, theme, child) {
        return MaterialApp(
          themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
          theme: theme.lightTheme,
          debugShowCheckedModeBanner: false,
          darkTheme: theme.darkTheme,
          home: const HomeScreen(),
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 400, name: MOBILE),
              const Breakpoint(start: 401, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: 'Home'.text(style: context.textTheme.displaySmall),
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0.0,
          backgroundColor: context.dynamicBackground1,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThemePage()),
                  );
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    foregroundColor: Palette.primary),
                child: 'Edit Light/Dark Mode Page'
                    .text(style: context.textTheme.titleMedium)),
            const SizedBox(height: 12),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MessengerPage()),
                  );
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    foregroundColor: Palette.primary),
                child: 'Responsive Messenger Page'
                    .text(style: context.textTheme.titleMedium)),
          ],
        ));
  }
}
