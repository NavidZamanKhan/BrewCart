import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void signUp(BuildContext context) {
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logo.png'),
            const SizedBox(height: 20),
            const SizedBox(width: 200),
            ElevatedButton(
              onPressed: () => signUp(context),
              child: const Text("Sign Up!"),
            ),
            Text(
              "Have an account?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            TextButton(
              onPressed: () => signUp(context),
              child: const Text("Sign Up!"),
            ),
          ],
        ),
      ),
    );
  }
}
