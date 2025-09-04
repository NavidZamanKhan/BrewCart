import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coffee_app/screens/splash_screen.dart';
import 'package:my_coffee_app/screens/auth.dart';
import 'package:my_coffee_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      return notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  refreshListenable: GoRouterRefreshStream(
    FirebaseAuth.instance.authStateChanges(),
  ),
  redirect: (context, state) {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final String loc = state.matchedLocation;

    if (!isLoggedIn && loc != '/auth' && loc != '/splash') {
      return '/auth';
    }

    if (isLoggedIn && (loc == '/auth' || loc == '/splash')) {
      return '/home';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),

    // GoRoute(
    //   path: '/signup',
    //   name: 'signup',
    //   builder: (context, state) => const SignupScreen(),
    // ),
    // GoRoute(
    //   path: '/home',
    //   name: 'home',
    //   builder: (context, state) => const HomeScreen(),
    // ),
  ],
  // TODO: Add error handling
  // errorBuilder: (context, state) => const ErrorScreen(),
);
