import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_coffee_app/model/user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserData? get userData => FirebaseFirestore.instance
      .collection('users')
      .doc(user?.uid)
      .get()
      .then((value) => UserData.fromFirestore(value.data() ?? {}));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, $userName 👋'),
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
                  'Welcome to BrewCart! $email',
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
