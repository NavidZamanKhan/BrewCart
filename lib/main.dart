import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_coffee_app/app/app.dart';

void main() {
  runApp(const ProviderScope(child: BrewCartApp()));
}
