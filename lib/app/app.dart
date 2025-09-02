import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_coffee_app/app/router/app_router.dart';
import 'package:my_coffee_app/app/theme/app_theme.dart';

class BrewCartApp extends ConsumerWidget {
  const BrewCartApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'BrewCart',
      theme: appTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
