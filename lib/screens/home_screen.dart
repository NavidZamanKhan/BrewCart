import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_coffee_app/models/user_data.dart';
import 'package:my_coffee_app/widgets/coffee_seach_bar.dart';
import 'package:my_coffee_app/widgets/home_screen_scrollable_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserData? user;

  Future<UserData?> _getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final data = doc.data();
    if (data == null) return null;
    return UserData.fromFirestore(data);
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
    setState(() {
      user = UserData.fromFirestore(doc.data()!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: FutureBuilder<UserData?>(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Hi, Loading...');
            }
            return Text('Hi, ${snapshot.data?.username ?? 'there'}');
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
      ),
      body: Column(
        spacing: 30,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: CoffeeSearchBar(),
          ),
          Expanded(child: HomeScreenScrollableSection()),
        ],
      ),
    );
  }
}
