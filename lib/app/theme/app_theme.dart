import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 160, 82, 45),
);

final appTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.nunitoTextTheme(),
  useMaterial3: true,
);
