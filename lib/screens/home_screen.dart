import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BrewCart Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        spacing: 30,
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Lottie.asset(
              'lib/assets/images/Waiting with a cup coffee.json',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Lottie.asset(
                  'lib/assets/images/Coffee love.json',
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to BrewCart!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Your coffee ordering app is ready!',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
