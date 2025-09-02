import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void signUp(BuildContext context) {
    // Use GoRouter to navigate to the auth screen (e.g., /signup or /login)
    // Assuming your GoRouter is set up and /signup route exists
    // If you want to go to a generic auth screen, change the route accordingly
    Navigator.of(context).pushNamed('/signup');
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
          ],
        ),
      ),
    );
  }
}
