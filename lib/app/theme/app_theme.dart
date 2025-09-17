import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 160, 82, 45),
);

final appTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.nunitoTextTheme(),
  useMaterial3: true,
  // Keep Scaffold background consistent across the app
  scaffoldBackgroundColor: colorScheme.onPrimary,
  // Make all AppBars visually identical to the screen
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.onPrimary,
    foregroundColor: colorScheme.primary,
    titleTextStyle: TextStyle(
      color: colorScheme.primary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
    scrolledUnderElevation: 0,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: colorScheme.onPrimary,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
);
