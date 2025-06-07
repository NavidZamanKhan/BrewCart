import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_coffee_app/screens/splash_screen.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 160, 82, 45),
);

final theme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.nunitoTextTheme(),
);

void main() {
  runApp(ProviderScope(child: MaterialApp(home: SplashScreen(), theme: theme)));
}
