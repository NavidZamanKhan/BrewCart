import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coffee_app/app/router/app_router.dart';
import 'package:my_coffee_app/app/theme/app_theme.dart';
import 'package:my_coffee_app/bloc/counter_bloc.dart';

class BrewCartApp extends StatelessWidget {
  const BrewCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CounterBloc();
      },
      child: MaterialApp.router(
        title: 'BrewCart',
        theme: appTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
