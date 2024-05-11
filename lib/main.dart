import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:barayafood/core/app_theme.dart';
import 'package:barayafood/src/data/repository/repository.dart';
import 'package:barayafood/src/presentation/screen/intro_screen.dart';
import 'package:barayafood/src/business_logic/provider/barayafood_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>(create: (context) => Repository()),
        ChangeNotifierProvider<BarayaFoodProvider>(
          create: (context) => BarayaFoodProvider(
            repository: context.read<Repository>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Enable horizontal scroll on flutter web
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        home: IntroScreen(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
