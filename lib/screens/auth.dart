import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontSize: 32)
                  .copyWith(fontWeight: FontWeight.w900)
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              obscureText: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                prefixIcon: Icon(Icons.email),
                labelText: "Email",
              ),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains("@")) {
                  return "Please enter a valid email address";
                }
              },
            ),

            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                prefixIcon: Icon(Icons.lock),
                labelText: "Password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 4) {
                  return "Please enter a valid password";
                }
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
